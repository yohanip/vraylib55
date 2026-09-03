cmake_minimum_required(VERSION 3.28)

project(vmain C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(vmain
    /home/yohanip/Dev/v/thirdparty/libgc/gc.c
)

# why? because when v -o generating main.c we need to define specific such as v -d emscripten
if(EMSCRIPTEN)
    target_sources(vmain PUBLIC main.wasm.c)
else()
    target_sources(vmain PUBLIC main.c)
endif()

target_include_directories(vmain PUBLIC
    c/raylib/src
    c/raylib-nuklear/include
    /home/yohanip/Dev/v/thirdparty/libgc/include
)

target_link_libraries(vmain
    raylib_nuke
    raylib
    m
)

if(EMSCRIPTEN)
    set_target_properties(vmain PROPERTIES
        SUFFIX ".html"
    )

    # for bugs signal() is not included on main.wasm.c
    target_compile_options(vmain PUBLIC
        -include signal.h
    )

    target_link_options(vmain PUBLIC
        -sUSE_GLFW=3
    )

    target_link_directories(vmain PUBLIC
        c/prebuilt/emscripten/Release/lib
    )
else()
    target_link_directories(vmain PUBLIC
        c/prebuilt/linux/Release/lib
    )
endif()

