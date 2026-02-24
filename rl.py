from pathlib import Path
import json, re

target_folder = Path(__file__).parent.joinpath("raylib")
main_file = target_folder.joinpath("raylib.v")

main_raylib_header = """module raylib

#include <raylib.h>

#flag -Ic/raylib/src
#flag -lraylib

$if emscripten ? {
    #flag emscripten -Lc/prebuilt/emscripten/Release/lib
    #flag -lc
    #flag -sUSE_GLFW=3
} $else {
    $if linux ? {
        #flag linux -Lc/prebuilt/linux/Release/lib
        #flag -lm
    }
}

pub struct C.va_list {}
pub struct C.rAudioBuffer {}
pub struct C.rAudioProcessor {}

"""

def to_snake_case(text):
    # Handle camelCase and PascalCase
    # text = re.sub(r'(?<!^)(?=[A-Z])', '_', text)  # Add underscore before capital letters
    # Replace spaces, hyphens with underscores
    text = re.sub(r'[-\s]+', '_', text)
    # Remove any non-alphanumeric characters except underscores
    text = re.sub(r'[^\w]', '', text)
    # Convert to lowercase and remove leading/trailing underscores
    return text.lower().strip('_')

consts = []
structs = []
aliases = []
enums = []
function_defs = []
functions = []

known_c_type = {
    "bool": "bool",
    "int": "i32",
    "long": "i64",
    "unsigned int": "u32",
    "short": "i16",
    "unsigned short": "u16",
    "unsigned char": "u8",
    "char": "char",
    "float": "f32",
    "double": "f64",
}

def to_v_type(c_type: str, c_name: str|None):
    if c_type == "...":
        return "...voidptr"

    primitive = False

    const_char_ptr = re.compile(r"const\s+char\s*\*")
    void_ptr = re.compile(r"(const\s)*void\s*\*")

    if const_char_ptr.match(c_type):
        primitive = True
        c_type = const_char_ptr.sub("&char", c_type)
    elif void_ptr.match(c_type):
        primitive = True
        c_type = void_ptr.sub("voidptr", c_type)

    ptr = "&" * c_type.count("*")
    c_type = c_type.replace("*", "").strip()

    bracket_index = c_type.find("[")
    if bracket_index != -1:
        ptr = c_type[bracket_index:] + ptr
        c_type = c_type[:bracket_index]

    for k, v in known_c_type.items():
        if k == c_type:
            c_type = ptr + v
            primitive = True
            break
    
    if not primitive:
        c_type = ptr + "C." + c_type
   
    if c_name is not None:
        return f'{c_name} {c_type}'
    else:
        return c_type

with open(Path(__file__).parent.joinpath("c/raylib/parser/output/raylib_api.json")) as f:
    raylib = json.load(f)
    for k, v in raylib.items():    
        if k == "defines":
            for item in v:
                typ = item['type']
                name = item['name']
                if typ in ["GUARD", "MACRO", "UNKNOWN"]:
                    continue
                elif typ == "INT":
                    consts.append(f"\npub const {to_snake_case(name)} = i32({item['value']})")
                elif typ == "STRING":
                    consts.append(f'\npub const {to_snake_case(name)} = &char("{item["value"]}".str)')
                elif typ == "FLOAT":
                    consts.append(f'\npub const {to_snake_case(name)} = f32({item["value"]})')
                elif typ == "FLOAT_MATH":
                    value: str = item['value']
                    value = value.replace("f", "").lower()
                    consts.append(f'\npub const {to_snake_case(name)} = f32{value}')
                elif typ == "COLOR":
                    consts.append(f'\npub const {to_snake_case(name)} = C.Color{item["value"][15:]}')
                else:
                    print(f"Unknown CONST type: {typ} for {name}")

        if k == "structs":
            for item in v:
                name = item['name']
                descs:str = item["description"]
                for desc in descs.splitlines():
                    structs.append(f"\n// {desc}")
                structs.append(name)
                structs.append(f"\npub struct C.{name} {{")
                for field in item['fields']:
                    field_name = field['name']
                    for desc in field["description"].splitlines():
                        structs.append(f"\n\t// {desc}")
                    structs.append(f"\n\t{to_v_type(field['type'], field_name)}")
                structs.append('\n}\n')

        if k == "aliases":
            for item in v:
                name = item['name']
                descs:str = item["description"]
                for desc in descs.splitlines():
                    aliases.append(f"\n// {desc}")
                aliases.append('\n@[typedef]')
                aliases.append(f"\npub struct C.{name} {{}}\n")

        if k == "enums":
            for item in v:
                name = item['name']
                descs:str = item["description"]
                for desc in descs.splitlines():
                    enums.append(f"\n// {desc}")
                enums.append(f"\npub enum {name} {{")
                for enum_item in item['values']:
                    field_descs:str = enum_item['description']
                    for desc in field_descs.splitlines():
                        enums.append(f"\n\t// {desc}")
                    field_name = enum_item['name'].lower()

                    if not('value' in enum_item):
                        enums.append(f"\n\t{field_name}")
                    else:
                        field_value = enum_item['value']
                        enums.append(f"\n\t{field_name} = {field_value}")
                enums.append('\n}\n')

        if k == "callbacks":
            for item in v:
                name = item['name']
                descs:str = item["description"]
                for desc in descs.splitlines():
                    function_defs.append(f"\n// {desc}")
                params = ", ".join([to_v_type(param['type'], param['name']) for param in item['params']])
                ret = ""
                if item['returnType'] != "void":
                    ret = to_v_type(item['returnType'], None)
                function_defs.append(f"\npub type C.{name} = fn({params}) {ret}\n")

        if k == "functions":
            for item in v:
                name = item['name']
                descs:str = item["description"]
                for desc in descs.splitlines():
                    functions.append(f"\n// {desc}")
                params = ""
                if 'params' in item:
                    params = ", ".join([to_v_type(param['type'], param['name']) for param in item['params']])
                ret = ""
                if item['returnType'] != "void":
                    ret = to_v_type(item['returnType'], None)
                functions.append(f"\npub fn C.{name}({params}) {ret}\n")


with open(main_file, "w") as f:
    f.write(main_raylib_header)
    f.write("\n\n// STRUCTS")
    f.writelines(structs)
    f.write("\n\n// ALIASES")
    f.writelines(aliases)
    f.write("\n\n// CONSTS")
    f.writelines(consts)
    f.write("\n\n// ENUMS")
    f.writelines(enums)
    f.write("\n\n// CALLBACKS")
    f.writelines(function_defs)
    f.write("\n\n// FUNCTIONS")
    f.writelines(functions)