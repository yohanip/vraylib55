module raylib

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

// STRUCTS
// Vector2, 2 componentsVector2
pub struct C.Vector2 {
	// Vector x component
	x f32
	// Vector y component
	y f32
}

// Vector3, 3 componentsVector3
pub struct C.Vector3 {
	// Vector x component
	x f32
	// Vector y component
	y f32
	// Vector z component
	z f32
}

// Vector4, 4 componentsVector4
pub struct C.Vector4 {
	// Vector x component
	x f32
	// Vector y component
	y f32
	// Vector z component
	z f32
	// Vector w component
	w f32
}

// Matrix, 4x4 components, column major, OpenGL style, right-handedMatrix
pub struct C.Matrix {
	// Matrix first row (4 components)
	m0 f32
	// Matrix first row (4 components)
	m4 f32
	// Matrix first row (4 components)
	m8 f32
	// Matrix first row (4 components)
	m12 f32
	// Matrix second row (4 components)
	m1 f32
	// Matrix second row (4 components)
	m5 f32
	// Matrix second row (4 components)
	m9 f32
	// Matrix second row (4 components)
	m13 f32
	// Matrix third row (4 components)
	m2 f32
	// Matrix third row (4 components)
	m6 f32
	// Matrix third row (4 components)
	m10 f32
	// Matrix third row (4 components)
	m14 f32
	// Matrix fourth row (4 components)
	m3 f32
	// Matrix fourth row (4 components)
	m7 f32
	// Matrix fourth row (4 components)
	m11 f32
	// Matrix fourth row (4 components)
	m15 f32
}

// Color, 4 components, R8G8B8A8 (32bit)Color
pub struct C.Color {
	// Color red value
	r u8
	// Color green value
	g u8
	// Color blue value
	b u8
	// Color alpha value
	a u8
}

// Rectangle, 4 componentsRectangle
pub struct C.Rectangle {
	// Rectangle top-left corner position x
	x f32
	// Rectangle top-left corner position y
	y f32
	// Rectangle width
	width f32
	// Rectangle height
	height f32
}

// Image, pixel data stored in CPU memory (RAM)Image
pub struct C.Image {
	// Image raw data
	data voidptr
	// Image base width
	width i32
	// Image base height
	height i32
	// Mipmap levels, 1 by default
	mipmaps i32
	// Data format (PixelFormat type)
	format i32
}

// Texture, tex data stored in GPU memory (VRAM)Texture
pub struct C.Texture {
	// OpenGL texture id
	id u32
	// Texture base width
	width i32
	// Texture base height
	height i32
	// Mipmap levels, 1 by default
	mipmaps i32
	// Data format (PixelFormat type)
	format i32
}

// RenderTexture, fbo for texture renderingRenderTexture
pub struct C.RenderTexture {
	// OpenGL framebuffer object id
	id u32
	// Color buffer attachment texture
	texture C.Texture
	// Depth buffer attachment texture
	depth C.Texture
}

// NPatchInfo, n-patch layout infoNPatchInfo
pub struct C.NPatchInfo {
	// Texture source rectangle
	source C.Rectangle
	// Left border offset
	left i32
	// Top border offset
	top i32
	// Right border offset
	right i32
	// Bottom border offset
	bottom i32
	// Layout of the n-patch: 3x3, 1x3 or 3x1
	layout i32
}

// GlyphInfo, font characters glyphs infoGlyphInfo
pub struct C.GlyphInfo {
	// Character value (Unicode)
	value i32
	// Character offset X when drawing
	offsetX i32
	// Character offset Y when drawing
	offsetY i32
	// Character advance position X
	advanceX i32
	// Character image data
	image C.Image
}

// Font, font texture and GlyphInfo array dataFont
pub struct C.Font {
	// Base size (default chars height)
	baseSize i32
	// Number of glyph characters
	glyphCount i32
	// Padding around the glyph characters
	glyphPadding i32
	// Texture atlas containing the glyphs
	texture C.Texture2D
	// Rectangles in texture for the glyphs
	recs &C.Rectangle
	// Glyphs info data
	glyphs &C.GlyphInfo
}

// Camera, defines position/orientation in 3d spaceCamera3D
pub struct C.Camera3D {
	// Camera position
	position C.Vector3
	// Camera target it looks-at
	target C.Vector3
	// Camera up vector (rotation over its axis)
	up C.Vector3
	// Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
	fovy f32
	// Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
	projection i32
}

// Camera2D, defines position/orientation in 2d spaceCamera2D
pub struct C.Camera2D {
	// Camera offset (displacement from target)
	offset C.Vector2
	// Camera target (rotation and zoom origin)
	target C.Vector2
	// Camera rotation in degrees
	rotation f32
	// Camera zoom (scaling), should be 1.0f by default
	zoom f32
}

// Mesh, vertex data and vao/vboMesh
pub struct C.Mesh {
	// Number of vertices stored in arrays
	vertexCount i32
	// Number of triangles stored (indexed or not)
	triangleCount i32
	// Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
	vertices &f32
	// Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
	texcoords &f32
	// Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
	texcoords2 &f32
	// Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
	normals &f32
	// Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
	tangents &f32
	// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
	colors &u8
	// Vertex indices (in case vertex data comes indexed)
	indices &u16
	// Animated vertex positions (after bones transformations)
	animVertices &f32
	// Animated normals (after bones transformations)
	animNormals &f32
	// Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning) (shader-location = 6)
	boneIds &u8
	// Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)
	boneWeights &f32
	// Bones animated transformation matrices
	boneMatrices &C.Matrix
	// Number of bones
	boneCount i32
	// OpenGL Vertex Array Object id
	vaoId u32
	// OpenGL Vertex Buffer Objects id (default vertex data)
	vboId &u32
}

// ShaderShader
pub struct C.Shader {
	// Shader program id
	id u32
	// Shader locations array (RL_MAX_SHADER_LOCATIONS)
	locs &i32
}

// MaterialMapMaterialMap
pub struct C.MaterialMap {
	// Material map texture
	texture C.Texture2D
	// Material map color
	color C.Color
	// Material map value
	value f32
}

// Material, includes shader and mapsMaterial
pub struct C.Material {
	// Material shader
	shader C.Shader
	// Material maps array (MAX_MATERIAL_MAPS)
	maps &C.MaterialMap
	// Material generic parameters (if required)
	params [4]f32
}

// Transform, vertex transformation dataTransform
pub struct C.Transform {
	// Translation
	translation C.Vector3
	// Rotation
	rotation C.Quaternion
	// Scale
	scale C.Vector3
}

// Bone, skeletal animation boneBoneInfo
pub struct C.BoneInfo {
	// Bone name
	name [32]char
	// Bone parent
	parent i32
}

// Model, meshes, materials and animation dataModel
pub struct C.Model {
	// Local transform matrix
	transform C.Matrix
	// Number of meshes
	meshCount i32
	// Number of materials
	materialCount i32
	// Meshes array
	meshes &C.Mesh
	// Materials array
	materials &C.Material
	// Mesh material number
	meshMaterial &i32
	// Number of bones
	boneCount i32
	// Bones information (skeleton)
	bones &C.BoneInfo
	// Bones base transformation (pose)
	bindPose &C.Transform
}

// ModelAnimationModelAnimation
pub struct C.ModelAnimation {
	// Number of bones
	boneCount i32
	// Number of animation frames
	frameCount i32
	// Bones information (skeleton)
	bones &C.BoneInfo
	// Poses array by frame
	framePoses &&C.Transform
	// Animation name
	name [32]char
}

// Ray, ray for raycastingRay
pub struct C.Ray {
	// Ray position (origin)
	position C.Vector3
	// Ray direction (normalized)
	direction C.Vector3
}

// RayCollision, ray hit informationRayCollision
pub struct C.RayCollision {
	// Did the ray hit something?
	hit bool
	// Distance to the nearest hit
	distance f32
	// Point of the nearest hit
	point C.Vector3
	// Surface normal of hit
	normal C.Vector3
}

// BoundingBoxBoundingBox
pub struct C.BoundingBox {
	// Minimum vertex box-corner
	min C.Vector3
	// Maximum vertex box-corner
	max C.Vector3
}

// Wave, audio wave dataWave
pub struct C.Wave {
	// Total number of frames (considering channels)
	frameCount u32
	// Frequency (samples per second)
	sampleRate u32
	// Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	sampleSize u32
	// Number of channels (1-mono, 2-stereo, ...)
	channels u32
	// Buffer data pointer
	data voidptr
}

// AudioStream, custom audio streamAudioStream
pub struct C.AudioStream {
	// Pointer to internal data used by the audio system
	buffer &C.rAudioBuffer
	// Pointer to internal data processor, useful for audio effects
	processor &C.rAudioProcessor
	// Frequency (samples per second)
	sampleRate u32
	// Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	sampleSize u32
	// Number of channels (1-mono, 2-stereo, ...)
	channels u32
}

// SoundSound
pub struct C.Sound {
	// Audio stream
	stream C.AudioStream
	// Total number of frames (considering channels)
	frameCount u32
}

// Music, audio stream, anything longer than ~10 seconds should be streamedMusic
pub struct C.Music {
	// Audio stream
	stream C.AudioStream
	// Total number of frames (considering channels)
	frameCount u32
	// Music looping enable
	looping bool
	// Type of music context (audio filetype)
	ctxType i32
	// Audio context data, depends on type
	ctxData voidptr
}

// VrDeviceInfo, Head-Mounted-Display device parametersVrDeviceInfo
pub struct C.VrDeviceInfo {
	// Horizontal resolution in pixels
	hResolution i32
	// Vertical resolution in pixels
	vResolution i32
	// Horizontal size in meters
	hScreenSize f32
	// Vertical size in meters
	vScreenSize f32
	// Distance between eye and display in meters
	eyeToScreenDistance f32
	// Lens separation distance in meters
	lensSeparationDistance f32
	// IPD (distance between pupils) in meters
	interpupillaryDistance f32
	// Lens distortion constant parameters
	lensDistortionValues [4]f32
	// Chromatic aberration correction parameters
	chromaAbCorrection [4]f32
}

// VrStereoConfig, VR stereo rendering configuration for simulatorVrStereoConfig
pub struct C.VrStereoConfig {
	// VR projection matrices (per eye)
	projection [2]C.Matrix
	// VR view offset matrices (per eye)
	viewOffset [2]C.Matrix
	// VR left lens center
	leftLensCenter [2]f32
	// VR right lens center
	rightLensCenter [2]f32
	// VR left screen center
	leftScreenCenter [2]f32
	// VR right screen center
	rightScreenCenter [2]f32
	// VR distortion scale
	scale [2]f32
	// VR distortion scale in
	scaleIn [2]f32
}

// File path listFilePathList
pub struct C.FilePathList {
	// Filepaths max entries
	capacity u32
	// Filepaths entries count
	count u32
	// Filepaths entries
	paths &&char
}

// Automation eventAutomationEvent
pub struct C.AutomationEvent {
	// Event frame
	frame u32
	// Event type (AutomationEventType)
	type u32
	// Event parameters (if required)
	params [4]i32
}

// Automation event listAutomationEventList
pub struct C.AutomationEventList {
	// Events max entries (MAX_AUTOMATION_EVENTS)
	capacity u32
	// Events entries count
	count u32
	// Events entries
	events &C.AutomationEvent
}


// ALIASES
// Quaternion, 4 components (Vector4 alias)
@[typedef]
pub struct C.Quaternion {}

// Texture2D, same as Texture
@[typedef]
pub struct C.Texture2D {}

// TextureCubemap, same as Texture
@[typedef]
pub struct C.TextureCubemap {}

// RenderTexture2D, same as RenderTexture
@[typedef]
pub struct C.RenderTexture2D {}

// Camera type fallback, defaults to Camera3D
@[typedef]
pub struct C.Camera {}


// CONSTS
pub const raylib_version_major = i32(5)
pub const raylib_version_minor = i32(5)
pub const raylib_version_patch = i32(0)
pub const raylib_version = &char("5.5".str)
pub const pi = f32(3.141592653589793)
pub const deg2rad = f32(pi/180.0)
pub const rad2deg = f32(180.0/pi)
pub const lightgray = C.Color{ 200, 200, 200, 255 }
pub const gray = C.Color{ 130, 130, 130, 255 }
pub const darkgray = C.Color{ 80, 80, 80, 255 }
pub const yellow = C.Color{ 253, 249, 0, 255 }
pub const gold = C.Color{ 255, 203, 0, 255 }
pub const orange = C.Color{ 255, 161, 0, 255 }
pub const pink = C.Color{ 255, 109, 194, 255 }
pub const red = C.Color{ 230, 41, 55, 255 }
pub const maroon = C.Color{ 190, 33, 55, 255 }
pub const green = C.Color{ 0, 228, 48, 255 }
pub const lime = C.Color{ 0, 158, 47, 255 }
pub const darkgreen = C.Color{ 0, 117, 44, 255 }
pub const skyblue = C.Color{ 102, 191, 255, 255 }
pub const blue = C.Color{ 0, 121, 241, 255 }
pub const darkblue = C.Color{ 0, 82, 172, 255 }
pub const purple = C.Color{ 200, 122, 255, 255 }
pub const violet = C.Color{ 135, 60, 190, 255 }
pub const darkpurple = C.Color{ 112, 31, 126, 255 }
pub const beige = C.Color{ 211, 176, 131, 255 }
pub const brown = C.Color{ 127, 106, 79, 255 }
pub const darkbrown = C.Color{ 76, 63, 47, 255 }
pub const white = C.Color{ 255, 255, 255, 255 }
pub const black = C.Color{ 0, 0, 0, 255 }
pub const blank = C.Color{ 0, 0, 0, 0 }
pub const magenta = C.Color{ 255, 0, 255, 255 }
pub const raywhite = C.Color{ 245, 245, 245, 255 }

// ENUMS
// System/Window config flags
pub enum ConfigFlags {
	// Set to try enabling V-Sync on GPU
	flag_vsync_hint = 64
	// Set to run program in fullscreen
	flag_fullscreen_mode = 2
	// Set to allow resizable window
	flag_window_resizable = 4
	// Set to disable window decoration (frame and buttons)
	flag_window_undecorated = 8
	// Set to hide window
	flag_window_hidden = 128
	// Set to minimize window (iconify)
	flag_window_minimized = 512
	// Set to maximize window (expanded to monitor)
	flag_window_maximized = 1024
	// Set to window non focused
	flag_window_unfocused = 2048
	// Set to window always on top
	flag_window_topmost = 4096
	// Set to allow windows running while minimized
	flag_window_always_run = 256
	// Set to allow transparent framebuffer
	flag_window_transparent = 16
	// Set to support HighDPI
	flag_window_highdpi = 8192
	// Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
	flag_window_mouse_passthrough = 16384
	// Set to run program in borderless windowed mode
	flag_borderless_windowed_mode = 32768
	// Set to try enabling MSAA 4X
	flag_msaa_4x_hint = 32
	// Set to try enabling interlaced video format (for V3D)
	flag_interlaced_hint = 65536
}

// Trace log level
pub enum TraceLogLevel {
	// Display all logs
	log_all = 0
	// Trace logging, intended for internal use only
	log_trace = 1
	// Debug logging, used for internal debugging, it should be disabled on release builds
	log_debug = 2
	// Info logging, used for program execution info
	log_info = 3
	// Warning logging, used on recoverable failures
	log_warning = 4
	// Error logging, used on unrecoverable failures
	log_error = 5
	// Fatal logging, used to abort program: exit(EXIT_FAILURE)
	log_fatal = 6
	// Disable logging
	log_none = 7
}

// Keyboard keys (US keyboard layout)
pub enum KeyboardKey {
	// Key: NULL, used for no key pressed
	key_null = 0
	// Key: '
	key_apostrophe = 39
	// Key: ,
	key_comma = 44
	// Key: -
	key_minus = 45
	// Key: .
	key_period = 46
	// Key: /
	key_slash = 47
	// Key: 0
	key_zero = 48
	// Key: 1
	key_one = 49
	// Key: 2
	key_two = 50
	// Key: 3
	key_three = 51
	// Key: 4
	key_four = 52
	// Key: 5
	key_five = 53
	// Key: 6
	key_six = 54
	// Key: 7
	key_seven = 55
	// Key: 8
	key_eight = 56
	// Key: 9
	key_nine = 57
	// Key: ;
	key_semicolon = 59
	// Key: =
	key_equal = 61
	// Key: A | a
	key_a = 65
	// Key: B | b
	key_b = 66
	// Key: C | c
	key_c = 67
	// Key: D | d
	key_d = 68
	// Key: E | e
	key_e = 69
	// Key: F | f
	key_f = 70
	// Key: G | g
	key_g = 71
	// Key: H | h
	key_h = 72
	// Key: I | i
	key_i = 73
	// Key: J | j
	key_j = 74
	// Key: K | k
	key_k = 75
	// Key: L | l
	key_l = 76
	// Key: M | m
	key_m = 77
	// Key: N | n
	key_n = 78
	// Key: O | o
	key_o = 79
	// Key: P | p
	key_p = 80
	// Key: Q | q
	key_q = 81
	// Key: R | r
	key_r = 82
	// Key: S | s
	key_s = 83
	// Key: T | t
	key_t = 84
	// Key: U | u
	key_u = 85
	// Key: V | v
	key_v = 86
	// Key: W | w
	key_w = 87
	// Key: X | x
	key_x = 88
	// Key: Y | y
	key_y = 89
	// Key: Z | z
	key_z = 90
	// Key: [
	key_left_bracket = 91
	// Key: '\'
	key_backslash = 92
	// Key: ]
	key_right_bracket = 93
	// Key: `
	key_grave = 96
	// Key: Space
	key_space = 32
	// Key: Esc
	key_escape = 256
	// Key: Enter
	key_enter = 257
	// Key: Tab
	key_tab = 258
	// Key: Backspace
	key_backspace = 259
	// Key: Ins
	key_insert = 260
	// Key: Del
	key_delete = 261
	// Key: Cursor right
	key_right = 262
	// Key: Cursor left
	key_left = 263
	// Key: Cursor down
	key_down = 264
	// Key: Cursor up
	key_up = 265
	// Key: Page up
	key_page_up = 266
	// Key: Page down
	key_page_down = 267
	// Key: Home
	key_home = 268
	// Key: End
	key_end = 269
	// Key: Caps lock
	key_caps_lock = 280
	// Key: Scroll down
	key_scroll_lock = 281
	// Key: Num lock
	key_num_lock = 282
	// Key: Print screen
	key_print_screen = 283
	// Key: Pause
	key_pause = 284
	// Key: F1
	key_f1 = 290
	// Key: F2
	key_f2 = 291
	// Key: F3
	key_f3 = 292
	// Key: F4
	key_f4 = 293
	// Key: F5
	key_f5 = 294
	// Key: F6
	key_f6 = 295
	// Key: F7
	key_f7 = 296
	// Key: F8
	key_f8 = 297
	// Key: F9
	key_f9 = 298
	// Key: F10
	key_f10 = 299
	// Key: F11
	key_f11 = 300
	// Key: F12
	key_f12 = 301
	// Key: Shift left
	key_left_shift = 340
	// Key: Control left
	key_left_control = 341
	// Key: Alt left
	key_left_alt = 342
	// Key: Super left
	key_left_super = 343
	// Key: Shift right
	key_right_shift = 344
	// Key: Control right
	key_right_control = 345
	// Key: Alt right
	key_right_alt = 346
	// Key: Super right
	key_right_super = 347
	// Key: KB menu
	key_kb_menu = 348
	// Key: Keypad 0
	key_kp_0 = 320
	// Key: Keypad 1
	key_kp_1 = 321
	// Key: Keypad 2
	key_kp_2 = 322
	// Key: Keypad 3
	key_kp_3 = 323
	// Key: Keypad 4
	key_kp_4 = 324
	// Key: Keypad 5
	key_kp_5 = 325
	// Key: Keypad 6
	key_kp_6 = 326
	// Key: Keypad 7
	key_kp_7 = 327
	// Key: Keypad 8
	key_kp_8 = 328
	// Key: Keypad 9
	key_kp_9 = 329
	// Key: Keypad .
	key_kp_decimal = 330
	// Key: Keypad /
	key_kp_divide = 331
	// Key: Keypad *
	key_kp_multiply = 332
	// Key: Keypad -
	key_kp_subtract = 333
	// Key: Keypad +
	key_kp_add = 334
	// Key: Keypad Enter
	key_kp_enter = 335
	// Key: Keypad =
	key_kp_equal = 336
	// Key: Android back button
	key_back = 4
	// Key: Android menu button
	key_menu = 5
	// Key: Android volume up button
	key_volume_up = 24
	// Key: Android volume down button
	key_volume_down = 25
}

// Mouse buttons
pub enum MouseButton {
	// Mouse button left
	mouse_button_left = 0
	// Mouse button right
	mouse_button_right = 1
	// Mouse button middle (pressed wheel)
	mouse_button_middle = 2
	// Mouse button side (advanced mouse device)
	mouse_button_side = 3
	// Mouse button extra (advanced mouse device)
	mouse_button_extra = 4
	// Mouse button forward (advanced mouse device)
	mouse_button_forward = 5
	// Mouse button back (advanced mouse device)
	mouse_button_back = 6
}

// Mouse cursor
pub enum MouseCursor {
	// Default pointer shape
	mouse_cursor_default = 0
	// Arrow shape
	mouse_cursor_arrow = 1
	// Text writing cursor shape
	mouse_cursor_ibeam = 2
	// Cross shape
	mouse_cursor_crosshair = 3
	// Pointing hand cursor
	mouse_cursor_pointing_hand = 4
	// Horizontal resize/move arrow shape
	mouse_cursor_resize_ew = 5
	// Vertical resize/move arrow shape
	mouse_cursor_resize_ns = 6
	// Top-left to bottom-right diagonal resize/move arrow shape
	mouse_cursor_resize_nwse = 7
	// The top-right to bottom-left diagonal resize/move arrow shape
	mouse_cursor_resize_nesw = 8
	// The omnidirectional resize/move cursor shape
	mouse_cursor_resize_all = 9
	// The operation-not-allowed shape
	mouse_cursor_not_allowed = 10
}

// Gamepad buttons
pub enum GamepadButton {
	// Unknown button, just for error checking
	gamepad_button_unknown = 0
	// Gamepad left DPAD up button
	gamepad_button_left_face_up = 1
	// Gamepad left DPAD right button
	gamepad_button_left_face_right = 2
	// Gamepad left DPAD down button
	gamepad_button_left_face_down = 3
	// Gamepad left DPAD left button
	gamepad_button_left_face_left = 4
	// Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
	gamepad_button_right_face_up = 5
	// Gamepad right button right (i.e. PS3: Circle, Xbox: B)
	gamepad_button_right_face_right = 6
	// Gamepad right button down (i.e. PS3: Cross, Xbox: A)
	gamepad_button_right_face_down = 7
	// Gamepad right button left (i.e. PS3: Square, Xbox: X)
	gamepad_button_right_face_left = 8
	// Gamepad top/back trigger left (first), it could be a trailing button
	gamepad_button_left_trigger_1 = 9
	// Gamepad top/back trigger left (second), it could be a trailing button
	gamepad_button_left_trigger_2 = 10
	// Gamepad top/back trigger right (first), it could be a trailing button
	gamepad_button_right_trigger_1 = 11
	// Gamepad top/back trigger right (second), it could be a trailing button
	gamepad_button_right_trigger_2 = 12
	// Gamepad center buttons, left one (i.e. PS3: Select)
	gamepad_button_middle_left = 13
	// Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
	gamepad_button_middle = 14
	// Gamepad center buttons, right one (i.e. PS3: Start)
	gamepad_button_middle_right = 15
	// Gamepad joystick pressed button left
	gamepad_button_left_thumb = 16
	// Gamepad joystick pressed button right
	gamepad_button_right_thumb = 17
}

// Gamepad axis
pub enum GamepadAxis {
	// Gamepad left stick X axis
	gamepad_axis_left_x = 0
	// Gamepad left stick Y axis
	gamepad_axis_left_y = 1
	// Gamepad right stick X axis
	gamepad_axis_right_x = 2
	// Gamepad right stick Y axis
	gamepad_axis_right_y = 3
	// Gamepad back trigger left, pressure level: [1..-1]
	gamepad_axis_left_trigger = 4
	// Gamepad back trigger right, pressure level: [1..-1]
	gamepad_axis_right_trigger = 5
}

// Material map index
pub enum MaterialMapIndex {
	// Albedo material (same as: MATERIAL_MAP_DIFFUSE)
	material_map_albedo = 0
	// Metalness material (same as: MATERIAL_MAP_SPECULAR)
	material_map_metalness = 1
	// Normal material
	material_map_normal = 2
	// Roughness material
	material_map_roughness = 3
	// Ambient occlusion material
	material_map_occlusion = 4
	// Emission material
	material_map_emission = 5
	// Heightmap material
	material_map_height = 6
	// Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
	material_map_cubemap = 7
	// Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
	material_map_irradiance = 8
	// Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
	material_map_prefilter = 9
	// Brdf material
	material_map_brdf = 10
}

// Shader location index
pub enum ShaderLocationIndex {
	// Shader location: vertex attribute: position
	shader_loc_vertex_position = 0
	// Shader location: vertex attribute: texcoord01
	shader_loc_vertex_texcoord01 = 1
	// Shader location: vertex attribute: texcoord02
	shader_loc_vertex_texcoord02 = 2
	// Shader location: vertex attribute: normal
	shader_loc_vertex_normal = 3
	// Shader location: vertex attribute: tangent
	shader_loc_vertex_tangent = 4
	// Shader location: vertex attribute: color
	shader_loc_vertex_color = 5
	// Shader location: matrix uniform: model-view-projection
	shader_loc_matrix_mvp = 6
	// Shader location: matrix uniform: view (camera transform)
	shader_loc_matrix_view = 7
	// Shader location: matrix uniform: projection
	shader_loc_matrix_projection = 8
	// Shader location: matrix uniform: model (transform)
	shader_loc_matrix_model = 9
	// Shader location: matrix uniform: normal
	shader_loc_matrix_normal = 10
	// Shader location: vector uniform: view
	shader_loc_vector_view = 11
	// Shader location: vector uniform: diffuse color
	shader_loc_color_diffuse = 12
	// Shader location: vector uniform: specular color
	shader_loc_color_specular = 13
	// Shader location: vector uniform: ambient color
	shader_loc_color_ambient = 14
	// Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
	shader_loc_map_albedo = 15
	// Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
	shader_loc_map_metalness = 16
	// Shader location: sampler2d texture: normal
	shader_loc_map_normal = 17
	// Shader location: sampler2d texture: roughness
	shader_loc_map_roughness = 18
	// Shader location: sampler2d texture: occlusion
	shader_loc_map_occlusion = 19
	// Shader location: sampler2d texture: emission
	shader_loc_map_emission = 20
	// Shader location: sampler2d texture: height
	shader_loc_map_height = 21
	// Shader location: samplerCube texture: cubemap
	shader_loc_map_cubemap = 22
	// Shader location: samplerCube texture: irradiance
	shader_loc_map_irradiance = 23
	// Shader location: samplerCube texture: prefilter
	shader_loc_map_prefilter = 24
	// Shader location: sampler2d texture: brdf
	shader_loc_map_brdf = 25
	// Shader location: vertex attribute: boneIds
	shader_loc_vertex_boneids = 26
	// Shader location: vertex attribute: boneWeights
	shader_loc_vertex_boneweights = 27
	// Shader location: array of matrices uniform: boneMatrices
	shader_loc_bone_matrices = 28
}

// Shader uniform data type
pub enum ShaderUniformDataType {
	// Shader uniform type: float
	shader_uniform_float = 0
	// Shader uniform type: vec2 (2 float)
	shader_uniform_vec2 = 1
	// Shader uniform type: vec3 (3 float)
	shader_uniform_vec3 = 2
	// Shader uniform type: vec4 (4 float)
	shader_uniform_vec4 = 3
	// Shader uniform type: int
	shader_uniform_int = 4
	// Shader uniform type: ivec2 (2 int)
	shader_uniform_ivec2 = 5
	// Shader uniform type: ivec3 (3 int)
	shader_uniform_ivec3 = 6
	// Shader uniform type: ivec4 (4 int)
	shader_uniform_ivec4 = 7
	// Shader uniform type: sampler2d
	shader_uniform_sampler2d = 8
}

// Shader attribute data types
pub enum ShaderAttributeDataType {
	// Shader attribute type: float
	shader_attrib_float = 0
	// Shader attribute type: vec2 (2 float)
	shader_attrib_vec2 = 1
	// Shader attribute type: vec3 (3 float)
	shader_attrib_vec3 = 2
	// Shader attribute type: vec4 (4 float)
	shader_attrib_vec4 = 3
}

// Pixel formats
pub enum PixelFormat {
	// 8 bit per pixel (no alpha)
	pixelformat_uncompressed_grayscale = 1
	// 8*2 bpp (2 channels)
	pixelformat_uncompressed_gray_alpha = 2
	// 16 bpp
	pixelformat_uncompressed_r5g6b5 = 3
	// 24 bpp
	pixelformat_uncompressed_r8g8b8 = 4
	// 16 bpp (1 bit alpha)
	pixelformat_uncompressed_r5g5b5a1 = 5
	// 16 bpp (4 bit alpha)
	pixelformat_uncompressed_r4g4b4a4 = 6
	// 32 bpp
	pixelformat_uncompressed_r8g8b8a8 = 7
	// 32 bpp (1 channel - float)
	pixelformat_uncompressed_r32 = 8
	// 32*3 bpp (3 channels - float)
	pixelformat_uncompressed_r32g32b32 = 9
	// 32*4 bpp (4 channels - float)
	pixelformat_uncompressed_r32g32b32a32 = 10
	// 16 bpp (1 channel - half float)
	pixelformat_uncompressed_r16 = 11
	// 16*3 bpp (3 channels - half float)
	pixelformat_uncompressed_r16g16b16 = 12
	// 16*4 bpp (4 channels - half float)
	pixelformat_uncompressed_r16g16b16a16 = 13
	// 4 bpp (no alpha)
	pixelformat_compressed_dxt1_rgb = 14
	// 4 bpp (1 bit alpha)
	pixelformat_compressed_dxt1_rgba = 15
	// 8 bpp
	pixelformat_compressed_dxt3_rgba = 16
	// 8 bpp
	pixelformat_compressed_dxt5_rgba = 17
	// 4 bpp
	pixelformat_compressed_etc1_rgb = 18
	// 4 bpp
	pixelformat_compressed_etc2_rgb = 19
	// 8 bpp
	pixelformat_compressed_etc2_eac_rgba = 20
	// 4 bpp
	pixelformat_compressed_pvrt_rgb = 21
	// 4 bpp
	pixelformat_compressed_pvrt_rgba = 22
	// 8 bpp
	pixelformat_compressed_astc_4x4_rgba = 23
	// 2 bpp
	pixelformat_compressed_astc_8x8_rgba = 24
}

// Texture parameters: filter mode
pub enum TextureFilter {
	// No filter, just pixel approximation
	texture_filter_point = 0
	// Linear filtering
	texture_filter_bilinear = 1
	// Trilinear filtering (linear with mipmaps)
	texture_filter_trilinear = 2
	// Anisotropic filtering 4x
	texture_filter_anisotropic_4x = 3
	// Anisotropic filtering 8x
	texture_filter_anisotropic_8x = 4
	// Anisotropic filtering 16x
	texture_filter_anisotropic_16x = 5
}

// Texture parameters: wrap mode
pub enum TextureWrap {
	// Repeats texture in tiled mode
	texture_wrap_repeat = 0
	// Clamps texture to edge pixel in tiled mode
	texture_wrap_clamp = 1
	// Mirrors and repeats the texture in tiled mode
	texture_wrap_mirror_repeat = 2
	// Mirrors and clamps to border the texture in tiled mode
	texture_wrap_mirror_clamp = 3
}

// Cubemap layouts
pub enum CubemapLayout {
	// Automatically detect layout type
	cubemap_layout_auto_detect = 0
	// Layout is defined by a vertical line with faces
	cubemap_layout_line_vertical = 1
	// Layout is defined by a horizontal line with faces
	cubemap_layout_line_horizontal = 2
	// Layout is defined by a 3x4 cross with cubemap faces
	cubemap_layout_cross_three_by_four = 3
	// Layout is defined by a 4x3 cross with cubemap faces
	cubemap_layout_cross_four_by_three = 4
}

// Font type, defines generation method
pub enum FontType {
	// Default font generation, anti-aliased
	font_default = 0
	// Bitmap font generation, no anti-aliasing
	font_bitmap = 1
	// SDF font generation, requires external shader
	font_sdf = 2
}

// Color blending modes (pre-defined)
pub enum BlendMode {
	// Blend textures considering alpha (default)
	blend_alpha = 0
	// Blend textures adding colors
	blend_additive = 1
	// Blend textures multiplying colors
	blend_multiplied = 2
	// Blend textures adding colors (alternative)
	blend_add_colors = 3
	// Blend textures subtracting colors (alternative)
	blend_subtract_colors = 4
	// Blend premultiplied textures considering alpha
	blend_alpha_premultiply = 5
	// Blend textures using custom src/dst factors (use rlSetBlendFactors())
	blend_custom = 6
	// Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparate())
	blend_custom_separate = 7
}

// Gesture
pub enum Gesture {
	// No gesture
	gesture_none = 0
	// Tap gesture
	gesture_tap = 1
	// Double tap gesture
	gesture_doubletap = 2
	// Hold gesture
	gesture_hold = 4
	// Drag gesture
	gesture_drag = 8
	// Swipe right gesture
	gesture_swipe_right = 16
	// Swipe left gesture
	gesture_swipe_left = 32
	// Swipe up gesture
	gesture_swipe_up = 64
	// Swipe down gesture
	gesture_swipe_down = 128
	// Pinch in gesture
	gesture_pinch_in = 256
	// Pinch out gesture
	gesture_pinch_out = 512
}

// Camera system modes
pub enum CameraMode {
	// Camera custom, controlled by user (UpdateCamera() does nothing)
	camera_custom = 0
	// Camera free mode
	camera_free = 1
	// Camera orbital, around target, zoom supported
	camera_orbital = 2
	// Camera first person
	camera_first_person = 3
	// Camera third person
	camera_third_person = 4
}

// Camera projection
pub enum CameraProjection {
	// Perspective projection
	camera_perspective = 0
	// Orthographic projection
	camera_orthographic = 1
}

// N-patch layout
pub enum NPatchLayout {
	// Npatch layout: 3x3 tiles
	npatch_nine_patch = 0
	// Npatch layout: 1x3 tiles
	npatch_three_patch_vertical = 1
	// Npatch layout: 3x1 tiles
	npatch_three_patch_horizontal = 2
}


// CALLBACKS
// Logging: Redirect trace log messages
pub type C.TraceLogCallback = fn(logLevel i32, text &char, args C.va_list) 

// FileIO: Load binary data
pub type C.LoadFileDataCallback = fn(fileName &char, dataSize &i32) &u8

// FileIO: Save binary data
pub type C.SaveFileDataCallback = fn(fileName &char, data voidptr, dataSize i32) bool

// FileIO: Load text data
pub type C.LoadFileTextCallback = fn(fileName &char) &char

// FileIO: Save text data
pub type C.SaveFileTextCallback = fn(fileName &char, text &char) bool

pub type C.AudioCallback = fn(bufferData voidptr, frames u32) 


// FUNCTIONS
// Initialize window and OpenGL context
pub fn C.InitWindow(width i32, height i32, title &char) 

// Close window and unload OpenGL context
pub fn C.CloseWindow() 

// Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
pub fn C.WindowShouldClose() bool

// Check if window has been initialized successfully
pub fn C.IsWindowReady() bool

// Check if window is currently fullscreen
pub fn C.IsWindowFullscreen() bool

// Check if window is currently hidden
pub fn C.IsWindowHidden() bool

// Check if window is currently minimized
pub fn C.IsWindowMinimized() bool

// Check if window is currently maximized
pub fn C.IsWindowMaximized() bool

// Check if window is currently focused
pub fn C.IsWindowFocused() bool

// Check if window has been resized last frame
pub fn C.IsWindowResized() bool

// Check if one specific window flag is enabled
pub fn C.IsWindowState(flag u32) bool

// Set window configuration state using flags
pub fn C.SetWindowState(flags u32) 

// Clear window configuration state flags
pub fn C.ClearWindowState(flags u32) 

// Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
pub fn C.ToggleFullscreen() 

// Toggle window state: borderless windowed, resizes window to match monitor resolution
pub fn C.ToggleBorderlessWindowed() 

// Set window state: maximized, if resizable
pub fn C.MaximizeWindow() 

// Set window state: minimized, if resizable
pub fn C.MinimizeWindow() 

// Set window state: not minimized/maximized
pub fn C.RestoreWindow() 

// Set icon for window (single image, RGBA 32bit)
pub fn C.SetWindowIcon(image C.Image) 

// Set icon for window (multiple images, RGBA 32bit)
pub fn C.SetWindowIcons(images &C.Image, count i32) 

// Set title for window
pub fn C.SetWindowTitle(title &char) 

// Set window position on screen
pub fn C.SetWindowPosition(x i32, y i32) 

// Set monitor for the current window
pub fn C.SetWindowMonitor(monitor i32) 

// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
pub fn C.SetWindowMinSize(width i32, height i32) 

// Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
pub fn C.SetWindowMaxSize(width i32, height i32) 

// Set window dimensions
pub fn C.SetWindowSize(width i32, height i32) 

// Set window opacity [0.0f..1.0f]
pub fn C.SetWindowOpacity(opacity f32) 

// Set window focused
pub fn C.SetWindowFocused() 

// Get native window handle
pub fn C.GetWindowHandle() voidptr

// Get current screen width
pub fn C.GetScreenWidth() i32

// Get current screen height
pub fn C.GetScreenHeight() i32

// Get current render width (it considers HiDPI)
pub fn C.GetRenderWidth() i32

// Get current render height (it considers HiDPI)
pub fn C.GetRenderHeight() i32

// Get number of connected monitors
pub fn C.GetMonitorCount() i32

// Get current monitor where window is placed
pub fn C.GetCurrentMonitor() i32

// Get specified monitor position
pub fn C.GetMonitorPosition(monitor i32) C.Vector2

// Get specified monitor width (current video mode used by monitor)
pub fn C.GetMonitorWidth(monitor i32) i32

// Get specified monitor height (current video mode used by monitor)
pub fn C.GetMonitorHeight(monitor i32) i32

// Get specified monitor physical width in millimetres
pub fn C.GetMonitorPhysicalWidth(monitor i32) i32

// Get specified monitor physical height in millimetres
pub fn C.GetMonitorPhysicalHeight(monitor i32) i32

// Get specified monitor refresh rate
pub fn C.GetMonitorRefreshRate(monitor i32) i32

// Get window position XY on monitor
pub fn C.GetWindowPosition() C.Vector2

// Get window scale DPI factor
pub fn C.GetWindowScaleDPI() C.Vector2

// Get the human-readable, UTF-8 encoded name of the specified monitor
pub fn C.GetMonitorName(monitor i32) &char

// Set clipboard text content
pub fn C.SetClipboardText(text &char) 

// Get clipboard text content
pub fn C.GetClipboardText() &char

// Get clipboard image content
pub fn C.GetClipboardImage() C.Image

// Enable waiting for events on EndDrawing(), no automatic event polling
pub fn C.EnableEventWaiting() 

// Disable waiting for events on EndDrawing(), automatic events polling
pub fn C.DisableEventWaiting() 

// Shows cursor
pub fn C.ShowCursor() 

// Hides cursor
pub fn C.HideCursor() 

// Check if cursor is not visible
pub fn C.IsCursorHidden() bool

// Enables cursor (unlock cursor)
pub fn C.EnableCursor() 

// Disables cursor (lock cursor)
pub fn C.DisableCursor() 

// Check if cursor is on the screen
pub fn C.IsCursorOnScreen() bool

// Set background color (framebuffer clear color)
pub fn C.ClearBackground(color C.Color) 

// Setup canvas (framebuffer) to start drawing
pub fn C.BeginDrawing() 

// End canvas drawing and swap buffers (double buffering)
pub fn C.EndDrawing() 

// Begin 2D mode with custom camera (2D)
pub fn C.BeginMode2D(camera C.Camera2D) 

// Ends 2D mode with custom camera
pub fn C.EndMode2D() 

// Begin 3D mode with custom camera (3D)
pub fn C.BeginMode3D(camera C.Camera3D) 

// Ends 3D mode and returns to default 2D orthographic mode
pub fn C.EndMode3D() 

// Begin drawing to render texture
pub fn C.BeginTextureMode(target C.RenderTexture2D) 

// Ends drawing to render texture
pub fn C.EndTextureMode() 

// Begin custom shader drawing
pub fn C.BeginShaderMode(shader C.Shader) 

// End custom shader drawing (use default shader)
pub fn C.EndShaderMode() 

// Begin blending mode (alpha, additive, multiplied, subtract, custom)
pub fn C.BeginBlendMode(mode i32) 

// End blending mode (reset to default: alpha blending)
pub fn C.EndBlendMode() 

// Begin scissor mode (define screen area for following drawing)
pub fn C.BeginScissorMode(x i32, y i32, width i32, height i32) 

// End scissor mode
pub fn C.EndScissorMode() 

// Begin stereo rendering (requires VR simulator)
pub fn C.BeginVrStereoMode(config C.VrStereoConfig) 

// End stereo rendering (requires VR simulator)
pub fn C.EndVrStereoMode() 

// Load VR stereo config for VR simulator device parameters
pub fn C.LoadVrStereoConfig(device C.VrDeviceInfo) C.VrStereoConfig

// Unload VR stereo config
pub fn C.UnloadVrStereoConfig(config C.VrStereoConfig) 

// Load shader from files and bind default locations
pub fn C.LoadShader(vsFileName &char, fsFileName &char) C.Shader

// Load shader from code strings and bind default locations
pub fn C.LoadShaderFromMemory(vsCode &char, fsCode &char) C.Shader

// Check if a shader is valid (loaded on GPU)
pub fn C.IsShaderValid(shader C.Shader) bool

// Get shader uniform location
pub fn C.GetShaderLocation(shader C.Shader, uniformName &char) i32

// Get shader attribute location
pub fn C.GetShaderLocationAttrib(shader C.Shader, attribName &char) i32

// Set shader uniform value
pub fn C.SetShaderValue(shader C.Shader, locIndex i32, value voidptr, uniformType i32) 

// Set shader uniform value vector
pub fn C.SetShaderValueV(shader C.Shader, locIndex i32, value voidptr, uniformType i32, count i32) 

// Set shader uniform value (matrix 4x4)
pub fn C.SetShaderValueMatrix(shader C.Shader, locIndex i32, mat C.Matrix) 

// Set shader uniform value for texture (sampler2d)
pub fn C.SetShaderValueTexture(shader C.Shader, locIndex i32, texture C.Texture2D) 

// Unload shader from GPU memory (VRAM)
pub fn C.UnloadShader(shader C.Shader) 

// Get a ray trace from screen position (i.e mouse)
pub fn C.GetScreenToWorldRay(position C.Vector2, camera C.Camera) C.Ray

// Get a ray trace from screen position (i.e mouse) in a viewport
pub fn C.GetScreenToWorldRayEx(position C.Vector2, camera C.Camera, width i32, height i32) C.Ray

// Get the screen space position for a 3d world space position
pub fn C.GetWorldToScreen(position C.Vector3, camera C.Camera) C.Vector2

// Get size position for a 3d world space position
pub fn C.GetWorldToScreenEx(position C.Vector3, camera C.Camera, width i32, height i32) C.Vector2

// Get the screen space position for a 2d camera world space position
pub fn C.GetWorldToScreen2D(position C.Vector2, camera C.Camera2D) C.Vector2

// Get the world space position for a 2d camera screen space position
pub fn C.GetScreenToWorld2D(position C.Vector2, camera C.Camera2D) C.Vector2

// Get camera transform matrix (view matrix)
pub fn C.GetCameraMatrix(camera C.Camera) C.Matrix

// Get camera 2d transform matrix
pub fn C.GetCameraMatrix2D(camera C.Camera2D) C.Matrix

// Set target FPS (maximum)
pub fn C.SetTargetFPS(fps i32) 

// Get time in seconds for last frame drawn (delta time)
pub fn C.GetFrameTime() f32

// Get elapsed time in seconds since InitWindow()
pub fn C.GetTime() f64

// Get current FPS
pub fn C.GetFPS() i32

// Swap back buffer with front buffer (screen drawing)
pub fn C.SwapScreenBuffer() 

// Register all input events
pub fn C.PollInputEvents() 

// Wait for some time (halt program execution)
pub fn C.WaitTime(seconds f64) 

// Set the seed for the random number generator
pub fn C.SetRandomSeed(seed u32) 

// Get a random value between min and max (both included)
pub fn C.GetRandomValue(min i32, max i32) i32

// Load random values sequence, no values repeated
pub fn C.LoadRandomSequence(count u32, min i32, max i32) &i32

// Unload random values sequence
pub fn C.UnloadRandomSequence(sequence &i32) 

// Takes a screenshot of current screen (filename extension defines format)
pub fn C.TakeScreenshot(fileName &char) 

// Setup init configuration flags (view FLAGS)
pub fn C.SetConfigFlags(flags u32) 

// Open URL with default system browser (if available)
pub fn C.OpenURL(url &char) 

// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
pub fn C.TraceLog(logLevel i32, text &char, ...voidptr) 

// Set the current threshold (minimum) log level
pub fn C.SetTraceLogLevel(logLevel i32) 

// Internal memory allocator
pub fn C.MemAlloc(size u32) voidptr

// Internal memory reallocator
pub fn C.MemRealloc(ptr voidptr, size u32) voidptr

// Internal memory free
pub fn C.MemFree(ptr voidptr) 

// Set custom trace log
pub fn C.SetTraceLogCallback(callback C.TraceLogCallback) 

// Set custom file binary data loader
pub fn C.SetLoadFileDataCallback(callback C.LoadFileDataCallback) 

// Set custom file binary data saver
pub fn C.SetSaveFileDataCallback(callback C.SaveFileDataCallback) 

// Set custom file text data loader
pub fn C.SetLoadFileTextCallback(callback C.LoadFileTextCallback) 

// Set custom file text data saver
pub fn C.SetSaveFileTextCallback(callback C.SaveFileTextCallback) 

// Load file data as byte array (read)
pub fn C.LoadFileData(fileName &char, dataSize &i32) &u8

// Unload file data allocated by LoadFileData()
pub fn C.UnloadFileData(data &u8) 

// Save data to file from byte array (write), returns true on success
pub fn C.SaveFileData(fileName &char, data voidptr, dataSize i32) bool

// Export data to code (.h), returns true on success
pub fn C.ExportDataAsCode(data &C.const unsigned char, dataSize i32, fileName &char) bool

// Load text data from file (read), returns a '\0' terminated string
pub fn C.LoadFileText(fileName &char) &char

// Unload file text data allocated by LoadFileText()
pub fn C.UnloadFileText(text &char) 

// Save text data to file (write), string must be '\0' terminated, returns true on success
pub fn C.SaveFileText(fileName &char, text &char) bool

// Check if file exists
pub fn C.FileExists(fileName &char) bool

// Check if a directory path exists
pub fn C.DirectoryExists(dirPath &char) bool

// Check file extension (including point: .png, .wav)
pub fn C.IsFileExtension(fileName &char, ext &char) bool

// Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
pub fn C.GetFileLength(fileName &char) i32

// Get pointer to extension for a filename string (includes dot: '.png')
pub fn C.GetFileExtension(fileName &char) &char

// Get pointer to filename for a path string
pub fn C.GetFileName(filePath &char) &char

// Get filename string without extension (uses static string)
pub fn C.GetFileNameWithoutExt(filePath &char) &char

// Get full path for a given fileName with path (uses static string)
pub fn C.GetDirectoryPath(filePath &char) &char

// Get previous directory path for a given path (uses static string)
pub fn C.GetPrevDirectoryPath(dirPath &char) &char

// Get current working directory (uses static string)
pub fn C.GetWorkingDirectory() &char

// Get the directory of the running application (uses static string)
pub fn C.GetApplicationDirectory() &char

// Create directories (including full path requested), returns 0 on success
pub fn C.MakeDirectory(dirPath &char) i32

// Change working directory, return true on success
pub fn C.ChangeDirectory(dir &char) bool

// Check if a given path is a file or a directory
pub fn C.IsPathFile(path &char) bool

// Check if fileName is valid for the platform/OS
pub fn C.IsFileNameValid(fileName &char) bool

// Load directory filepaths
pub fn C.LoadDirectoryFiles(dirPath &char) C.FilePathList

// Load directory filepaths with extension filtering and recursive directory scan. Use 'DIR' in the filter string to include directories in the result
pub fn C.LoadDirectoryFilesEx(basePath &char, filter &char, scanSubdirs bool) C.FilePathList

// Unload filepaths
pub fn C.UnloadDirectoryFiles(files C.FilePathList) 

// Check if a file has been dropped into window
pub fn C.IsFileDropped() bool

// Load dropped filepaths
pub fn C.LoadDroppedFiles() C.FilePathList

// Unload dropped filepaths
pub fn C.UnloadDroppedFiles(files C.FilePathList) 

// Get file modification time (last write time)
pub fn C.GetFileModTime(fileName &char) i64

// Compress data (DEFLATE algorithm), memory must be MemFree()
pub fn C.CompressData(data &C.const unsigned char, dataSize i32, compDataSize &i32) &u8

// Decompress data (DEFLATE algorithm), memory must be MemFree()
pub fn C.DecompressData(compData &C.const unsigned char, compDataSize i32, dataSize &i32) &u8

// Encode data to Base64 string, memory must be MemFree()
pub fn C.EncodeDataBase64(data &C.const unsigned char, dataSize i32, outputSize &i32) &char

// Decode Base64 string data, memory must be MemFree()
pub fn C.DecodeDataBase64(data &C.const unsigned char, outputSize &i32) &u8

// Compute CRC32 hash code
pub fn C.ComputeCRC32(data &u8, dataSize i32) u32

// Compute MD5 hash code, returns static int[4] (16 bytes)
pub fn C.ComputeMD5(data &u8, dataSize i32) &u32

// Compute SHA1 hash code, returns static int[5] (20 bytes)
pub fn C.ComputeSHA1(data &u8, dataSize i32) &u32

// Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
pub fn C.LoadAutomationEventList(fileName &char) C.AutomationEventList

// Unload automation events list from file
pub fn C.UnloadAutomationEventList(list C.AutomationEventList) 

// Export automation events list as text file
pub fn C.ExportAutomationEventList(list C.AutomationEventList, fileName &char) bool

// Set automation event list to record to
pub fn C.SetAutomationEventList(list &C.AutomationEventList) 

// Set automation event internal base frame to start recording
pub fn C.SetAutomationEventBaseFrame(frame i32) 

// Start recording automation events (AutomationEventList must be set)
pub fn C.StartAutomationEventRecording() 

// Stop recording automation events
pub fn C.StopAutomationEventRecording() 

// Play a recorded automation event
pub fn C.PlayAutomationEvent(event C.AutomationEvent) 

// Check if a key has been pressed once
pub fn C.IsKeyPressed(key i32) bool

// Check if a key has been pressed again
pub fn C.IsKeyPressedRepeat(key i32) bool

// Check if a key is being pressed
pub fn C.IsKeyDown(key i32) bool

// Check if a key has been released once
pub fn C.IsKeyReleased(key i32) bool

// Check if a key is NOT being pressed
pub fn C.IsKeyUp(key i32) bool

// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
pub fn C.GetKeyPressed() i32

// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
pub fn C.GetCharPressed() i32

// Set a custom key to exit program (default is ESC)
pub fn C.SetExitKey(key i32) 

// Check if a gamepad is available
pub fn C.IsGamepadAvailable(gamepad i32) bool

// Get gamepad internal name id
pub fn C.GetGamepadName(gamepad i32) &char

// Check if a gamepad button has been pressed once
pub fn C.IsGamepadButtonPressed(gamepad i32, button i32) bool

// Check if a gamepad button is being pressed
pub fn C.IsGamepadButtonDown(gamepad i32, button i32) bool

// Check if a gamepad button has been released once
pub fn C.IsGamepadButtonReleased(gamepad i32, button i32) bool

// Check if a gamepad button is NOT being pressed
pub fn C.IsGamepadButtonUp(gamepad i32, button i32) bool

// Get the last gamepad button pressed
pub fn C.GetGamepadButtonPressed() i32

// Get gamepad axis count for a gamepad
pub fn C.GetGamepadAxisCount(gamepad i32) i32

// Get axis movement value for a gamepad axis
pub fn C.GetGamepadAxisMovement(gamepad i32, axis i32) f32

// Set internal gamepad mappings (SDL_GameControllerDB)
pub fn C.SetGamepadMappings(mappings &char) i32

// Set gamepad vibration for both motors (duration in seconds)
pub fn C.SetGamepadVibration(gamepad i32, leftMotor f32, rightMotor f32, duration f32) 

// Check if a mouse button has been pressed once
pub fn C.IsMouseButtonPressed(button i32) bool

// Check if a mouse button is being pressed
pub fn C.IsMouseButtonDown(button i32) bool

// Check if a mouse button has been released once
pub fn C.IsMouseButtonReleased(button i32) bool

// Check if a mouse button is NOT being pressed
pub fn C.IsMouseButtonUp(button i32) bool

// Get mouse position X
pub fn C.GetMouseX() i32

// Get mouse position Y
pub fn C.GetMouseY() i32

// Get mouse position XY
pub fn C.GetMousePosition() C.Vector2

// Get mouse delta between frames
pub fn C.GetMouseDelta() C.Vector2

// Set mouse position XY
pub fn C.SetMousePosition(x i32, y i32) 

// Set mouse offset
pub fn C.SetMouseOffset(offsetX i32, offsetY i32) 

// Set mouse scaling
pub fn C.SetMouseScale(scaleX f32, scaleY f32) 

// Get mouse wheel movement for X or Y, whichever is larger
pub fn C.GetMouseWheelMove() f32

// Get mouse wheel movement for both X and Y
pub fn C.GetMouseWheelMoveV() C.Vector2

// Set mouse cursor
pub fn C.SetMouseCursor(cursor i32) 

// Get touch position X for touch point 0 (relative to screen size)
pub fn C.GetTouchX() i32

// Get touch position Y for touch point 0 (relative to screen size)
pub fn C.GetTouchY() i32

// Get touch position XY for a touch point index (relative to screen size)
pub fn C.GetTouchPosition(index i32) C.Vector2

// Get touch point identifier for given index
pub fn C.GetTouchPointId(index i32) i32

// Get number of touch points
pub fn C.GetTouchPointCount() i32

// Enable a set of gestures using flags
pub fn C.SetGesturesEnabled(flags u32) 

// Check if a gesture have been detected
pub fn C.IsGestureDetected(gesture u32) bool

// Get latest detected gesture
pub fn C.GetGestureDetected() i32

// Get gesture hold time in seconds
pub fn C.GetGestureHoldDuration() f32

// Get gesture drag vector
pub fn C.GetGestureDragVector() C.Vector2

// Get gesture drag angle
pub fn C.GetGestureDragAngle() f32

// Get gesture pinch delta
pub fn C.GetGesturePinchVector() C.Vector2

// Get gesture pinch angle
pub fn C.GetGesturePinchAngle() f32

// Update camera position for selected mode
pub fn C.UpdateCamera(camera &C.Camera, mode i32) 

// Update camera movement/rotation
pub fn C.UpdateCameraPro(camera &C.Camera, movement C.Vector3, rotation C.Vector3, zoom f32) 

// Set texture and rectangle to be used on shapes drawing
pub fn C.SetShapesTexture(texture C.Texture2D, source C.Rectangle) 

// Get texture that is used for shapes drawing
pub fn C.GetShapesTexture() C.Texture2D

// Get texture source rectangle that is used for shapes drawing
pub fn C.GetShapesTextureRectangle() C.Rectangle

// Draw a pixel using geometry [Can be slow, use with care]
pub fn C.DrawPixel(posX i32, posY i32, color C.Color) 

// Draw a pixel using geometry (Vector version) [Can be slow, use with care]
pub fn C.DrawPixelV(position C.Vector2, color C.Color) 

// Draw a line
pub fn C.DrawLine(startPosX i32, startPosY i32, endPosX i32, endPosY i32, color C.Color) 

// Draw a line (using gl lines)
pub fn C.DrawLineV(startPos C.Vector2, endPos C.Vector2, color C.Color) 

// Draw a line (using triangles/quads)
pub fn C.DrawLineEx(startPos C.Vector2, endPos C.Vector2, thick f32, color C.Color) 

// Draw lines sequence (using gl lines)
pub fn C.DrawLineStrip(points &C.const Vector2, pointCount i32, color C.Color) 

// Draw line segment cubic-bezier in-out interpolation
pub fn C.DrawLineBezier(startPos C.Vector2, endPos C.Vector2, thick f32, color C.Color) 

// Draw a color-filled circle
pub fn C.DrawCircle(centerX i32, centerY i32, radius f32, color C.Color) 

// Draw a piece of a circle
pub fn C.DrawCircleSector(center C.Vector2, radius f32, startAngle f32, endAngle f32, segments i32, color C.Color) 

// Draw circle sector outline
pub fn C.DrawCircleSectorLines(center C.Vector2, radius f32, startAngle f32, endAngle f32, segments i32, color C.Color) 

// Draw a gradient-filled circle
pub fn C.DrawCircleGradient(centerX i32, centerY i32, radius f32, inner C.Color, outer C.Color) 

// Draw a color-filled circle (Vector version)
pub fn C.DrawCircleV(center C.Vector2, radius f32, color C.Color) 

// Draw circle outline
pub fn C.DrawCircleLines(centerX i32, centerY i32, radius f32, color C.Color) 

// Draw circle outline (Vector version)
pub fn C.DrawCircleLinesV(center C.Vector2, radius f32, color C.Color) 

// Draw ellipse
pub fn C.DrawEllipse(centerX i32, centerY i32, radiusH f32, radiusV f32, color C.Color) 

// Draw ellipse outline
pub fn C.DrawEllipseLines(centerX i32, centerY i32, radiusH f32, radiusV f32, color C.Color) 

// Draw ring
pub fn C.DrawRing(center C.Vector2, innerRadius f32, outerRadius f32, startAngle f32, endAngle f32, segments i32, color C.Color) 

// Draw ring outline
pub fn C.DrawRingLines(center C.Vector2, innerRadius f32, outerRadius f32, startAngle f32, endAngle f32, segments i32, color C.Color) 

// Draw a color-filled rectangle
pub fn C.DrawRectangle(posX i32, posY i32, width i32, height i32, color C.Color) 

// Draw a color-filled rectangle (Vector version)
pub fn C.DrawRectangleV(position C.Vector2, size C.Vector2, color C.Color) 

// Draw a color-filled rectangle
pub fn C.DrawRectangleRec(rec C.Rectangle, color C.Color) 

// Draw a color-filled rectangle with pro parameters
pub fn C.DrawRectanglePro(rec C.Rectangle, origin C.Vector2, rotation f32, color C.Color) 

// Draw a vertical-gradient-filled rectangle
pub fn C.DrawRectangleGradientV(posX i32, posY i32, width i32, height i32, top C.Color, bottom C.Color) 

// Draw a horizontal-gradient-filled rectangle
pub fn C.DrawRectangleGradientH(posX i32, posY i32, width i32, height i32, left C.Color, right C.Color) 

// Draw a gradient-filled rectangle with custom vertex colors
pub fn C.DrawRectangleGradientEx(rec C.Rectangle, topLeft C.Color, bottomLeft C.Color, topRight C.Color, bottomRight C.Color) 

// Draw rectangle outline
pub fn C.DrawRectangleLines(posX i32, posY i32, width i32, height i32, color C.Color) 

// Draw rectangle outline with extended parameters
pub fn C.DrawRectangleLinesEx(rec C.Rectangle, lineThick f32, color C.Color) 

// Draw rectangle with rounded edges
pub fn C.DrawRectangleRounded(rec C.Rectangle, roundness f32, segments i32, color C.Color) 

// Draw rectangle lines with rounded edges
pub fn C.DrawRectangleRoundedLines(rec C.Rectangle, roundness f32, segments i32, color C.Color) 

// Draw rectangle with rounded edges outline
pub fn C.DrawRectangleRoundedLinesEx(rec C.Rectangle, roundness f32, segments i32, lineThick f32, color C.Color) 

// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub fn C.DrawTriangle(v1 C.Vector2, v2 C.Vector2, v3 C.Vector2, color C.Color) 

// Draw triangle outline (vertex in counter-clockwise order!)
pub fn C.DrawTriangleLines(v1 C.Vector2, v2 C.Vector2, v3 C.Vector2, color C.Color) 

// Draw a triangle fan defined by points (first vertex is the center)
pub fn C.DrawTriangleFan(points &C.const Vector2, pointCount i32, color C.Color) 

// Draw a triangle strip defined by points
pub fn C.DrawTriangleStrip(points &C.const Vector2, pointCount i32, color C.Color) 

// Draw a regular polygon (Vector version)
pub fn C.DrawPoly(center C.Vector2, sides i32, radius f32, rotation f32, color C.Color) 

// Draw a polygon outline of n sides
pub fn C.DrawPolyLines(center C.Vector2, sides i32, radius f32, rotation f32, color C.Color) 

// Draw a polygon outline of n sides with extended parameters
pub fn C.DrawPolyLinesEx(center C.Vector2, sides i32, radius f32, rotation f32, lineThick f32, color C.Color) 

// Draw spline: Linear, minimum 2 points
pub fn C.DrawSplineLinear(points &C.const Vector2, pointCount i32, thick f32, color C.Color) 

// Draw spline: B-Spline, minimum 4 points
pub fn C.DrawSplineBasis(points &C.const Vector2, pointCount i32, thick f32, color C.Color) 

// Draw spline: Catmull-Rom, minimum 4 points
pub fn C.DrawSplineCatmullRom(points &C.const Vector2, pointCount i32, thick f32, color C.Color) 

// Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
pub fn C.DrawSplineBezierQuadratic(points &C.const Vector2, pointCount i32, thick f32, color C.Color) 

// Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
pub fn C.DrawSplineBezierCubic(points &C.const Vector2, pointCount i32, thick f32, color C.Color) 

// Draw spline segment: Linear, 2 points
pub fn C.DrawSplineSegmentLinear(p1 C.Vector2, p2 C.Vector2, thick f32, color C.Color) 

// Draw spline segment: B-Spline, 4 points
pub fn C.DrawSplineSegmentBasis(p1 C.Vector2, p2 C.Vector2, p3 C.Vector2, p4 C.Vector2, thick f32, color C.Color) 

// Draw spline segment: Catmull-Rom, 4 points
pub fn C.DrawSplineSegmentCatmullRom(p1 C.Vector2, p2 C.Vector2, p3 C.Vector2, p4 C.Vector2, thick f32, color C.Color) 

// Draw spline segment: Quadratic Bezier, 2 points, 1 control point
pub fn C.DrawSplineSegmentBezierQuadratic(p1 C.Vector2, c2 C.Vector2, p3 C.Vector2, thick f32, color C.Color) 

// Draw spline segment: Cubic Bezier, 2 points, 2 control points
pub fn C.DrawSplineSegmentBezierCubic(p1 C.Vector2, c2 C.Vector2, c3 C.Vector2, p4 C.Vector2, thick f32, color C.Color) 

// Get (evaluate) spline point: Linear
pub fn C.GetSplinePointLinear(startPos C.Vector2, endPos C.Vector2, t f32) C.Vector2

// Get (evaluate) spline point: B-Spline
pub fn C.GetSplinePointBasis(p1 C.Vector2, p2 C.Vector2, p3 C.Vector2, p4 C.Vector2, t f32) C.Vector2

// Get (evaluate) spline point: Catmull-Rom
pub fn C.GetSplinePointCatmullRom(p1 C.Vector2, p2 C.Vector2, p3 C.Vector2, p4 C.Vector2, t f32) C.Vector2

// Get (evaluate) spline point: Quadratic Bezier
pub fn C.GetSplinePointBezierQuad(p1 C.Vector2, c2 C.Vector2, p3 C.Vector2, t f32) C.Vector2

// Get (evaluate) spline point: Cubic Bezier
pub fn C.GetSplinePointBezierCubic(p1 C.Vector2, c2 C.Vector2, c3 C.Vector2, p4 C.Vector2, t f32) C.Vector2

// Check collision between two rectangles
pub fn C.CheckCollisionRecs(rec1 C.Rectangle, rec2 C.Rectangle) bool

// Check collision between two circles
pub fn C.CheckCollisionCircles(center1 C.Vector2, radius1 f32, center2 C.Vector2, radius2 f32) bool

// Check collision between circle and rectangle
pub fn C.CheckCollisionCircleRec(center C.Vector2, radius f32, rec C.Rectangle) bool

// Check if circle collides with a line created betweeen two points [p1] and [p2]
pub fn C.CheckCollisionCircleLine(center C.Vector2, radius f32, p1 C.Vector2, p2 C.Vector2) bool

// Check if point is inside rectangle
pub fn C.CheckCollisionPointRec(point C.Vector2, rec C.Rectangle) bool

// Check if point is inside circle
pub fn C.CheckCollisionPointCircle(point C.Vector2, center C.Vector2, radius f32) bool

// Check if point is inside a triangle
pub fn C.CheckCollisionPointTriangle(point C.Vector2, p1 C.Vector2, p2 C.Vector2, p3 C.Vector2) bool

// Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
pub fn C.CheckCollisionPointLine(point C.Vector2, p1 C.Vector2, p2 C.Vector2, threshold i32) bool

// Check if point is within a polygon described by array of vertices
pub fn C.CheckCollisionPointPoly(point C.Vector2, points &C.const Vector2, pointCount i32) bool

// Check the collision between two lines defined by two points each, returns collision point by reference
pub fn C.CheckCollisionLines(startPos1 C.Vector2, endPos1 C.Vector2, startPos2 C.Vector2, endPos2 C.Vector2, collisionPoint &C.Vector2) bool

// Get collision rectangle for two rectangles collision
pub fn C.GetCollisionRec(rec1 C.Rectangle, rec2 C.Rectangle) C.Rectangle

// Load image from file into CPU memory (RAM)
pub fn C.LoadImage(fileName &char) C.Image

// Load image from RAW file data
pub fn C.LoadImageRaw(fileName &char, width i32, height i32, format i32, headerSize i32) C.Image

// Load image sequence from file (frames appended to image.data)
pub fn C.LoadImageAnim(fileName &char, frames &i32) C.Image

// Load image sequence from memory buffer
pub fn C.LoadImageAnimFromMemory(fileType &char, fileData &C.const unsigned char, dataSize i32, frames &i32) C.Image

// Load image from memory buffer, fileType refers to extension: i.e. '.png'
pub fn C.LoadImageFromMemory(fileType &char, fileData &C.const unsigned char, dataSize i32) C.Image

// Load image from GPU texture data
pub fn C.LoadImageFromTexture(texture C.Texture2D) C.Image

// Load image from screen buffer and (screenshot)
pub fn C.LoadImageFromScreen() C.Image

// Check if an image is valid (data and parameters)
pub fn C.IsImageValid(image C.Image) bool

// Unload image from CPU memory (RAM)
pub fn C.UnloadImage(image C.Image) 

// Export image data to file, returns true on success
pub fn C.ExportImage(image C.Image, fileName &char) bool

// Export image to memory buffer
pub fn C.ExportImageToMemory(image C.Image, fileType &char, fileSize &i32) &u8

// Export image as code file defining an array of bytes, returns true on success
pub fn C.ExportImageAsCode(image C.Image, fileName &char) bool

// Generate image: plain color
pub fn C.GenImageColor(width i32, height i32, color C.Color) C.Image

// Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
pub fn C.GenImageGradientLinear(width i32, height i32, direction i32, start C.Color, end C.Color) C.Image

// Generate image: radial gradient
pub fn C.GenImageGradientRadial(width i32, height i32, density f32, inner C.Color, outer C.Color) C.Image

// Generate image: square gradient
pub fn C.GenImageGradientSquare(width i32, height i32, density f32, inner C.Color, outer C.Color) C.Image

// Generate image: checked
pub fn C.GenImageChecked(width i32, height i32, checksX i32, checksY i32, col1 C.Color, col2 C.Color) C.Image

// Generate image: white noise
pub fn C.GenImageWhiteNoise(width i32, height i32, factor f32) C.Image

// Generate image: perlin noise
pub fn C.GenImagePerlinNoise(width i32, height i32, offsetX i32, offsetY i32, scale f32) C.Image

// Generate image: cellular algorithm, bigger tileSize means bigger cells
pub fn C.GenImageCellular(width i32, height i32, tileSize i32) C.Image

// Generate image: grayscale image from text data
pub fn C.GenImageText(width i32, height i32, text &char) C.Image

// Create an image duplicate (useful for transformations)
pub fn C.ImageCopy(image C.Image) C.Image

// Create an image from another image piece
pub fn C.ImageFromImage(image C.Image, rec C.Rectangle) C.Image

// Create an image from a selected channel of another image (GRAYSCALE)
pub fn C.ImageFromChannel(image C.Image, selectedChannel i32) C.Image

// Create an image from text (default font)
pub fn C.ImageText(text &char, fontSize i32, color C.Color) C.Image

// Create an image from text (custom sprite font)
pub fn C.ImageTextEx(font C.Font, text &char, fontSize f32, spacing f32, tint C.Color) C.Image

// Convert image data to desired format
pub fn C.ImageFormat(image &C.Image, newFormat i32) 

// Convert image to POT (power-of-two)
pub fn C.ImageToPOT(image &C.Image, fill C.Color) 

// Crop an image to a defined rectangle
pub fn C.ImageCrop(image &C.Image, crop C.Rectangle) 

// Crop image depending on alpha value
pub fn C.ImageAlphaCrop(image &C.Image, threshold f32) 

// Clear alpha channel to desired color
pub fn C.ImageAlphaClear(image &C.Image, color C.Color, threshold f32) 

// Apply alpha mask to image
pub fn C.ImageAlphaMask(image &C.Image, alphaMask C.Image) 

// Premultiply alpha channel
pub fn C.ImageAlphaPremultiply(image &C.Image) 

// Apply Gaussian blur using a box blur approximation
pub fn C.ImageBlurGaussian(image &C.Image, blurSize i32) 

// Apply custom square convolution kernel to image
pub fn C.ImageKernelConvolution(image &C.Image, kernel &C.const float, kernelSize i32) 

// Resize image (Bicubic scaling algorithm)
pub fn C.ImageResize(image &C.Image, newWidth i32, newHeight i32) 

// Resize image (Nearest-Neighbor scaling algorithm)
pub fn C.ImageResizeNN(image &C.Image, newWidth i32, newHeight i32) 

// Resize canvas and fill with color
pub fn C.ImageResizeCanvas(image &C.Image, newWidth i32, newHeight i32, offsetX i32, offsetY i32, fill C.Color) 

// Compute all mipmap levels for a provided image
pub fn C.ImageMipmaps(image &C.Image) 

// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
pub fn C.ImageDither(image &C.Image, rBpp i32, gBpp i32, bBpp i32, aBpp i32) 

// Flip image vertically
pub fn C.ImageFlipVertical(image &C.Image) 

// Flip image horizontally
pub fn C.ImageFlipHorizontal(image &C.Image) 

// Rotate image by input angle in degrees (-359 to 359)
pub fn C.ImageRotate(image &C.Image, degrees i32) 

// Rotate image clockwise 90deg
pub fn C.ImageRotateCW(image &C.Image) 

// Rotate image counter-clockwise 90deg
pub fn C.ImageRotateCCW(image &C.Image) 

// Modify image color: tint
pub fn C.ImageColorTint(image &C.Image, color C.Color) 

// Modify image color: invert
pub fn C.ImageColorInvert(image &C.Image) 

// Modify image color: grayscale
pub fn C.ImageColorGrayscale(image &C.Image) 

// Modify image color: contrast (-100 to 100)
pub fn C.ImageColorContrast(image &C.Image, contrast f32) 

// Modify image color: brightness (-255 to 255)
pub fn C.ImageColorBrightness(image &C.Image, brightness i32) 

// Modify image color: replace color
pub fn C.ImageColorReplace(image &C.Image, color C.Color, replace C.Color) 

// Load color data from image as a Color array (RGBA - 32bit)
pub fn C.LoadImageColors(image C.Image) &C.Color

// Load colors palette from image as a Color array (RGBA - 32bit)
pub fn C.LoadImagePalette(image C.Image, maxPaletteSize i32, colorCount &i32) &C.Color

// Unload color data loaded with LoadImageColors()
pub fn C.UnloadImageColors(colors &C.Color) 

// Unload colors palette loaded with LoadImagePalette()
pub fn C.UnloadImagePalette(colors &C.Color) 

// Get image alpha border rectangle
pub fn C.GetImageAlphaBorder(image C.Image, threshold f32) C.Rectangle

// Get image pixel color at (x, y) position
pub fn C.GetImageColor(image C.Image, x i32, y i32) C.Color

// Clear image background with given color
pub fn C.ImageClearBackground(dst &C.Image, color C.Color) 

// Draw pixel within an image
pub fn C.ImageDrawPixel(dst &C.Image, posX i32, posY i32, color C.Color) 

// Draw pixel within an image (Vector version)
pub fn C.ImageDrawPixelV(dst &C.Image, position C.Vector2, color C.Color) 

// Draw line within an image
pub fn C.ImageDrawLine(dst &C.Image, startPosX i32, startPosY i32, endPosX i32, endPosY i32, color C.Color) 

// Draw line within an image (Vector version)
pub fn C.ImageDrawLineV(dst &C.Image, start C.Vector2, end C.Vector2, color C.Color) 

// Draw a line defining thickness within an image
pub fn C.ImageDrawLineEx(dst &C.Image, start C.Vector2, end C.Vector2, thick i32, color C.Color) 

// Draw a filled circle within an image
pub fn C.ImageDrawCircle(dst &C.Image, centerX i32, centerY i32, radius i32, color C.Color) 

// Draw a filled circle within an image (Vector version)
pub fn C.ImageDrawCircleV(dst &C.Image, center C.Vector2, radius i32, color C.Color) 

// Draw circle outline within an image
pub fn C.ImageDrawCircleLines(dst &C.Image, centerX i32, centerY i32, radius i32, color C.Color) 

// Draw circle outline within an image (Vector version)
pub fn C.ImageDrawCircleLinesV(dst &C.Image, center C.Vector2, radius i32, color C.Color) 

// Draw rectangle within an image
pub fn C.ImageDrawRectangle(dst &C.Image, posX i32, posY i32, width i32, height i32, color C.Color) 

// Draw rectangle within an image (Vector version)
pub fn C.ImageDrawRectangleV(dst &C.Image, position C.Vector2, size C.Vector2, color C.Color) 

// Draw rectangle within an image
pub fn C.ImageDrawRectangleRec(dst &C.Image, rec C.Rectangle, color C.Color) 

// Draw rectangle lines within an image
pub fn C.ImageDrawRectangleLines(dst &C.Image, rec C.Rectangle, thick i32, color C.Color) 

// Draw triangle within an image
pub fn C.ImageDrawTriangle(dst &C.Image, v1 C.Vector2, v2 C.Vector2, v3 C.Vector2, color C.Color) 

// Draw triangle with interpolated colors within an image
pub fn C.ImageDrawTriangleEx(dst &C.Image, v1 C.Vector2, v2 C.Vector2, v3 C.Vector2, c1 C.Color, c2 C.Color, c3 C.Color) 

// Draw triangle outline within an image
pub fn C.ImageDrawTriangleLines(dst &C.Image, v1 C.Vector2, v2 C.Vector2, v3 C.Vector2, color C.Color) 

// Draw a triangle fan defined by points within an image (first vertex is the center)
pub fn C.ImageDrawTriangleFan(dst &C.Image, points &C.Vector2, pointCount i32, color C.Color) 

// Draw a triangle strip defined by points within an image
pub fn C.ImageDrawTriangleStrip(dst &C.Image, points &C.Vector2, pointCount i32, color C.Color) 

// Draw a source image within a destination image (tint applied to source)
pub fn C.ImageDraw(dst &C.Image, src C.Image, srcRec C.Rectangle, dstRec C.Rectangle, tint C.Color) 

// Draw text (using default font) within an image (destination)
pub fn C.ImageDrawText(dst &C.Image, text &char, posX i32, posY i32, fontSize i32, color C.Color) 

// Draw text (custom sprite font) within an image (destination)
pub fn C.ImageDrawTextEx(dst &C.Image, font C.Font, text &char, position C.Vector2, fontSize f32, spacing f32, tint C.Color) 

// Load texture from file into GPU memory (VRAM)
pub fn C.LoadTexture(fileName &char) C.Texture2D

// Load texture from image data
pub fn C.LoadTextureFromImage(image C.Image) C.Texture2D

// Load cubemap from image, multiple image cubemap layouts supported
pub fn C.LoadTextureCubemap(image C.Image, layout i32) C.TextureCubemap

// Load texture for rendering (framebuffer)
pub fn C.LoadRenderTexture(width i32, height i32) C.RenderTexture2D

// Check if a texture is valid (loaded in GPU)
pub fn C.IsTextureValid(texture C.Texture2D) bool

// Unload texture from GPU memory (VRAM)
pub fn C.UnloadTexture(texture C.Texture2D) 

// Check if a render texture is valid (loaded in GPU)
pub fn C.IsRenderTextureValid(target C.RenderTexture2D) bool

// Unload render texture from GPU memory (VRAM)
pub fn C.UnloadRenderTexture(target C.RenderTexture2D) 

// Update GPU texture with new data
pub fn C.UpdateTexture(texture C.Texture2D, pixels voidptr) 

// Update GPU texture rectangle with new data
pub fn C.UpdateTextureRec(texture C.Texture2D, rec C.Rectangle, pixels voidptr) 

// Generate GPU mipmaps for a texture
pub fn C.GenTextureMipmaps(texture &C.Texture2D) 

// Set texture scaling filter mode
pub fn C.SetTextureFilter(texture C.Texture2D, filter i32) 

// Set texture wrapping mode
pub fn C.SetTextureWrap(texture C.Texture2D, wrap i32) 

// Draw a Texture2D
pub fn C.DrawTexture(texture C.Texture2D, posX i32, posY i32, tint C.Color) 

// Draw a Texture2D with position defined as Vector2
pub fn C.DrawTextureV(texture C.Texture2D, position C.Vector2, tint C.Color) 

// Draw a Texture2D with extended parameters
pub fn C.DrawTextureEx(texture C.Texture2D, position C.Vector2, rotation f32, scale f32, tint C.Color) 

// Draw a part of a texture defined by a rectangle
pub fn C.DrawTextureRec(texture C.Texture2D, source C.Rectangle, position C.Vector2, tint C.Color) 

// Draw a part of a texture defined by a rectangle with 'pro' parameters
pub fn C.DrawTexturePro(texture C.Texture2D, source C.Rectangle, dest C.Rectangle, origin C.Vector2, rotation f32, tint C.Color) 

// Draws a texture (or part of it) that stretches or shrinks nicely
pub fn C.DrawTextureNPatch(texture C.Texture2D, nPatchInfo C.NPatchInfo, dest C.Rectangle, origin C.Vector2, rotation f32, tint C.Color) 

// Check if two colors are equal
pub fn C.ColorIsEqual(col1 C.Color, col2 C.Color) bool

// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn C.Fade(color C.Color, alpha f32) C.Color

// Get hexadecimal value for a Color (0xRRGGBBAA)
pub fn C.ColorToInt(color C.Color) i32

// Get Color normalized as float [0..1]
pub fn C.ColorNormalize(color C.Color) C.Vector4

// Get Color from normalized values [0..1]
pub fn C.ColorFromNormalized(normalized C.Vector4) C.Color

// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
pub fn C.ColorToHSV(color C.Color) C.Vector3

// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
pub fn C.ColorFromHSV(hue f32, saturation f32, value f32) C.Color

// Get color multiplied with another color
pub fn C.ColorTint(color C.Color, tint C.Color) C.Color

// Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
pub fn C.ColorBrightness(color C.Color, factor f32) C.Color

// Get color with contrast correction, contrast values between -1.0f and 1.0f
pub fn C.ColorContrast(color C.Color, contrast f32) C.Color

// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn C.ColorAlpha(color C.Color, alpha f32) C.Color

// Get src alpha-blended into dst color with tint
pub fn C.ColorAlphaBlend(dst C.Color, src C.Color, tint C.Color) C.Color

// Get color lerp interpolation between two colors, factor [0.0f..1.0f]
pub fn C.ColorLerp(color1 C.Color, color2 C.Color, factor f32) C.Color

// Get Color structure from hexadecimal value
pub fn C.GetColor(hexValue u32) C.Color

// Get Color from a source pixel pointer of certain format
pub fn C.GetPixelColor(srcPtr voidptr, format i32) C.Color

// Set color formatted into destination pixel pointer
pub fn C.SetPixelColor(dstPtr voidptr, color C.Color, format i32) 

// Get pixel data size in bytes for certain format
pub fn C.GetPixelDataSize(width i32, height i32, format i32) i32

// Get the default Font
pub fn C.GetFontDefault() C.Font

// Load font from file into GPU memory (VRAM)
pub fn C.LoadFont(fileName &char) C.Font

// Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
pub fn C.LoadFontEx(fileName &char, fontSize i32, codepoints &i32, codepointCount i32) C.Font

// Load font from Image (XNA style)
pub fn C.LoadFontFromImage(image C.Image, key C.Color, firstChar i32) C.Font

// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
pub fn C.LoadFontFromMemory(fileType &char, fileData &C.const unsigned char, dataSize i32, fontSize i32, codepoints &i32, codepointCount i32) C.Font

// Check if a font is valid (font data loaded, WARNING: GPU texture not checked)
pub fn C.IsFontValid(font C.Font) bool

// Load font data for further use
pub fn C.LoadFontData(fileData &C.const unsigned char, dataSize i32, fontSize i32, codepoints &i32, codepointCount i32, type i32) &C.GlyphInfo

// Generate image font atlas using chars info
pub fn C.GenImageFontAtlas(glyphs &C.const GlyphInfo, glyphRecs &&C.Rectangle, glyphCount i32, fontSize i32, padding i32, packMethod i32) C.Image

// Unload font chars info data (RAM)
pub fn C.UnloadFontData(glyphs &C.GlyphInfo, glyphCount i32) 

// Unload font from GPU memory (VRAM)
pub fn C.UnloadFont(font C.Font) 

// Export font as code file, returns true on success
pub fn C.ExportFontAsCode(font C.Font, fileName &char) bool

// Draw current FPS
pub fn C.DrawFPS(posX i32, posY i32) 

// Draw text (using default font)
pub fn C.DrawText(text &char, posX i32, posY i32, fontSize i32, color C.Color) 

// Draw text using font and additional parameters
pub fn C.DrawTextEx(font C.Font, text &char, position C.Vector2, fontSize f32, spacing f32, tint C.Color) 

// Draw text using Font and pro parameters (rotation)
pub fn C.DrawTextPro(font C.Font, text &char, position C.Vector2, origin C.Vector2, rotation f32, fontSize f32, spacing f32, tint C.Color) 

// Draw one character (codepoint)
pub fn C.DrawTextCodepoint(font C.Font, codepoint i32, position C.Vector2, fontSize f32, tint C.Color) 

// Draw multiple character (codepoint)
pub fn C.DrawTextCodepoints(font C.Font, codepoints &C.const int, codepointCount i32, position C.Vector2, fontSize f32, spacing f32, tint C.Color) 

// Set vertical line spacing when drawing with line-breaks
pub fn C.SetTextLineSpacing(spacing i32) 

// Measure string width for default font
pub fn C.MeasureText(text &char, fontSize i32) i32

// Measure string size for Font
pub fn C.MeasureTextEx(font C.Font, text &char, fontSize f32, spacing f32) C.Vector2

// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
pub fn C.GetGlyphIndex(font C.Font, codepoint i32) i32

// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
pub fn C.GetGlyphInfo(font C.Font, codepoint i32) C.GlyphInfo

// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
pub fn C.GetGlyphAtlasRec(font C.Font, codepoint i32) C.Rectangle

// Load UTF-8 text encoded from codepoints array
pub fn C.LoadUTF8(codepoints &C.const int, length i32) &char

// Unload UTF-8 text encoded from codepoints array
pub fn C.UnloadUTF8(text &char) 

// Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
pub fn C.LoadCodepoints(text &char, count &i32) &i32

// Unload codepoints data from memory
pub fn C.UnloadCodepoints(codepoints &i32) 

// Get total number of codepoints in a UTF-8 encoded string
pub fn C.GetCodepointCount(text &char) i32

// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub fn C.GetCodepoint(text &char, codepointSize &i32) i32

// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub fn C.GetCodepointNext(text &char, codepointSize &i32) i32

// Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub fn C.GetCodepointPrevious(text &char, codepointSize &i32) i32

// Encode one codepoint into UTF-8 byte array (array length returned as parameter)
pub fn C.CodepointToUTF8(codepoint i32, utf8Size &i32) &char

// Copy one string to another, returns bytes copied
pub fn C.TextCopy(dst &char, src &char) i32

// Check if two text string are equal
pub fn C.TextIsEqual(text1 &char, text2 &char) bool

// Get text length, checks for '\0' ending
pub fn C.TextLength(text &char) u32

// Text formatting with variables (sprintf() style)
pub fn C.TextFormat(text &char, ...voidptr) &char

// Get a piece of a text string
pub fn C.TextSubtext(text &char, position i32, length i32) &char

// Replace text string (WARNING: memory must be freed!)
pub fn C.TextReplace(text &char, replace &char, by &char) &char

// Insert text in a position (WARNING: memory must be freed!)
pub fn C.TextInsert(text &char, insert &char, position i32) &char

// Join text strings with delimiter
pub fn C.TextJoin(textList &char, count i32, delimiter &char) &char

// Split text into multiple strings
pub fn C.TextSplit(text &char, delimiter char, count &i32) &char

// Append text at specific position and move cursor!
pub fn C.TextAppend(text &char, append &char, position &i32) 

// Find first text occurrence within a string
pub fn C.TextFindIndex(text &char, find &char) i32

// Get upper case version of provided string
pub fn C.TextToUpper(text &char) &char

// Get lower case version of provided string
pub fn C.TextToLower(text &char) &char

// Get Pascal case notation version of provided string
pub fn C.TextToPascal(text &char) &char

// Get Snake case notation version of provided string
pub fn C.TextToSnake(text &char) &char

// Get Camel case notation version of provided string
pub fn C.TextToCamel(text &char) &char

// Get integer value from text (negative values not supported)
pub fn C.TextToInteger(text &char) i32

// Get float value from text (negative values not supported)
pub fn C.TextToFloat(text &char) f32

// Draw a line in 3D world space
pub fn C.DrawLine3D(startPos C.Vector3, endPos C.Vector3, color C.Color) 

// Draw a point in 3D space, actually a small line
pub fn C.DrawPoint3D(position C.Vector3, color C.Color) 

// Draw a circle in 3D world space
pub fn C.DrawCircle3D(center C.Vector3, radius f32, rotationAxis C.Vector3, rotationAngle f32, color C.Color) 

// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub fn C.DrawTriangle3D(v1 C.Vector3, v2 C.Vector3, v3 C.Vector3, color C.Color) 

// Draw a triangle strip defined by points
pub fn C.DrawTriangleStrip3D(points &C.const Vector3, pointCount i32, color C.Color) 

// Draw cube
pub fn C.DrawCube(position C.Vector3, width f32, height f32, length f32, color C.Color) 

// Draw cube (Vector version)
pub fn C.DrawCubeV(position C.Vector3, size C.Vector3, color C.Color) 

// Draw cube wires
pub fn C.DrawCubeWires(position C.Vector3, width f32, height f32, length f32, color C.Color) 

// Draw cube wires (Vector version)
pub fn C.DrawCubeWiresV(position C.Vector3, size C.Vector3, color C.Color) 

// Draw sphere
pub fn C.DrawSphere(centerPos C.Vector3, radius f32, color C.Color) 

// Draw sphere with extended parameters
pub fn C.DrawSphereEx(centerPos C.Vector3, radius f32, rings i32, slices i32, color C.Color) 

// Draw sphere wires
pub fn C.DrawSphereWires(centerPos C.Vector3, radius f32, rings i32, slices i32, color C.Color) 

// Draw a cylinder/cone
pub fn C.DrawCylinder(position C.Vector3, radiusTop f32, radiusBottom f32, height f32, slices i32, color C.Color) 

// Draw a cylinder with base at startPos and top at endPos
pub fn C.DrawCylinderEx(startPos C.Vector3, endPos C.Vector3, startRadius f32, endRadius f32, sides i32, color C.Color) 

// Draw a cylinder/cone wires
pub fn C.DrawCylinderWires(position C.Vector3, radiusTop f32, radiusBottom f32, height f32, slices i32, color C.Color) 

// Draw a cylinder wires with base at startPos and top at endPos
pub fn C.DrawCylinderWiresEx(startPos C.Vector3, endPos C.Vector3, startRadius f32, endRadius f32, sides i32, color C.Color) 

// Draw a capsule with the center of its sphere caps at startPos and endPos
pub fn C.DrawCapsule(startPos C.Vector3, endPos C.Vector3, radius f32, slices i32, rings i32, color C.Color) 

// Draw capsule wireframe with the center of its sphere caps at startPos and endPos
pub fn C.DrawCapsuleWires(startPos C.Vector3, endPos C.Vector3, radius f32, slices i32, rings i32, color C.Color) 

// Draw a plane XZ
pub fn C.DrawPlane(centerPos C.Vector3, size C.Vector2, color C.Color) 

// Draw a ray line
pub fn C.DrawRay(ray C.Ray, color C.Color) 

// Draw a grid (centered at (0, 0, 0))
pub fn C.DrawGrid(slices i32, spacing f32) 

// Load model from files (meshes and materials)
pub fn C.LoadModel(fileName &char) C.Model

// Load model from generated mesh (default material)
pub fn C.LoadModelFromMesh(mesh C.Mesh) C.Model

// Check if a model is valid (loaded in GPU, VAO/VBOs)
pub fn C.IsModelValid(model C.Model) bool

// Unload model (including meshes) from memory (RAM and/or VRAM)
pub fn C.UnloadModel(model C.Model) 

// Compute model bounding box limits (considers all meshes)
pub fn C.GetModelBoundingBox(model C.Model) C.BoundingBox

// Draw a model (with texture if set)
pub fn C.DrawModel(model C.Model, position C.Vector3, scale f32, tint C.Color) 

// Draw a model with extended parameters
pub fn C.DrawModelEx(model C.Model, position C.Vector3, rotationAxis C.Vector3, rotationAngle f32, scale C.Vector3, tint C.Color) 

// Draw a model wires (with texture if set)
pub fn C.DrawModelWires(model C.Model, position C.Vector3, scale f32, tint C.Color) 

// Draw a model wires (with texture if set) with extended parameters
pub fn C.DrawModelWiresEx(model C.Model, position C.Vector3, rotationAxis C.Vector3, rotationAngle f32, scale C.Vector3, tint C.Color) 

// Draw a model as points
pub fn C.DrawModelPoints(model C.Model, position C.Vector3, scale f32, tint C.Color) 

// Draw a model as points with extended parameters
pub fn C.DrawModelPointsEx(model C.Model, position C.Vector3, rotationAxis C.Vector3, rotationAngle f32, scale C.Vector3, tint C.Color) 

// Draw bounding box (wires)
pub fn C.DrawBoundingBox(box C.BoundingBox, color C.Color) 

// Draw a billboard texture
pub fn C.DrawBillboard(camera C.Camera, texture C.Texture2D, position C.Vector3, scale f32, tint C.Color) 

// Draw a billboard texture defined by source
pub fn C.DrawBillboardRec(camera C.Camera, texture C.Texture2D, source C.Rectangle, position C.Vector3, size C.Vector2, tint C.Color) 

// Draw a billboard texture defined by source and rotation
pub fn C.DrawBillboardPro(camera C.Camera, texture C.Texture2D, source C.Rectangle, position C.Vector3, up C.Vector3, size C.Vector2, origin C.Vector2, rotation f32, tint C.Color) 

// Upload mesh vertex data in GPU and provide VAO/VBO ids
pub fn C.UploadMesh(mesh &C.Mesh, dynamic bool) 

// Update mesh vertex data in GPU for a specific buffer index
pub fn C.UpdateMeshBuffer(mesh C.Mesh, index i32, data voidptr, dataSize i32, offset i32) 

// Unload mesh data from CPU and GPU
pub fn C.UnloadMesh(mesh C.Mesh) 

// Draw a 3d mesh with material and transform
pub fn C.DrawMesh(mesh C.Mesh, material C.Material, transform C.Matrix) 

// Draw multiple mesh instances with material and different transforms
pub fn C.DrawMeshInstanced(mesh C.Mesh, material C.Material, transforms &C.const Matrix, instances i32) 

// Compute mesh bounding box limits
pub fn C.GetMeshBoundingBox(mesh C.Mesh) C.BoundingBox

// Compute mesh tangents
pub fn C.GenMeshTangents(mesh &C.Mesh) 

// Export mesh data to file, returns true on success
pub fn C.ExportMesh(mesh C.Mesh, fileName &char) bool

// Export mesh as code file (.h) defining multiple arrays of vertex attributes
pub fn C.ExportMeshAsCode(mesh C.Mesh, fileName &char) bool

// Generate polygonal mesh
pub fn C.GenMeshPoly(sides i32, radius f32) C.Mesh

// Generate plane mesh (with subdivisions)
pub fn C.GenMeshPlane(width f32, length f32, resX i32, resZ i32) C.Mesh

// Generate cuboid mesh
pub fn C.GenMeshCube(width f32, height f32, length f32) C.Mesh

// Generate sphere mesh (standard sphere)
pub fn C.GenMeshSphere(radius f32, rings i32, slices i32) C.Mesh

// Generate half-sphere mesh (no bottom cap)
pub fn C.GenMeshHemiSphere(radius f32, rings i32, slices i32) C.Mesh

// Generate cylinder mesh
pub fn C.GenMeshCylinder(radius f32, height f32, slices i32) C.Mesh

// Generate cone/pyramid mesh
pub fn C.GenMeshCone(radius f32, height f32, slices i32) C.Mesh

// Generate torus mesh
pub fn C.GenMeshTorus(radius f32, size f32, radSeg i32, sides i32) C.Mesh

// Generate trefoil knot mesh
pub fn C.GenMeshKnot(radius f32, size f32, radSeg i32, sides i32) C.Mesh

// Generate heightmap mesh from image data
pub fn C.GenMeshHeightmap(heightmap C.Image, size C.Vector3) C.Mesh

// Generate cubes-based map mesh from image data
pub fn C.GenMeshCubicmap(cubicmap C.Image, cubeSize C.Vector3) C.Mesh

// Load materials from model file
pub fn C.LoadMaterials(fileName &char, materialCount &i32) &C.Material

// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
pub fn C.LoadMaterialDefault() C.Material

// Check if a material is valid (shader assigned, map textures loaded in GPU)
pub fn C.IsMaterialValid(material C.Material) bool

// Unload material from GPU memory (VRAM)
pub fn C.UnloadMaterial(material C.Material) 

// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
pub fn C.SetMaterialTexture(material &C.Material, mapType i32, texture C.Texture2D) 

// Set material for a mesh
pub fn C.SetModelMeshMaterial(model &C.Model, meshId i32, materialId i32) 

// Load model animations from file
pub fn C.LoadModelAnimations(fileName &char, animCount &i32) &C.ModelAnimation

// Update model animation pose (CPU)
pub fn C.UpdateModelAnimation(model C.Model, anim C.ModelAnimation, frame i32) 

// Update model animation mesh bone matrices (GPU skinning)
pub fn C.UpdateModelAnimationBones(model C.Model, anim C.ModelAnimation, frame i32) 

// Unload animation data
pub fn C.UnloadModelAnimation(anim C.ModelAnimation) 

// Unload animation array data
pub fn C.UnloadModelAnimations(animations &C.ModelAnimation, animCount i32) 

// Check model animation skeleton match
pub fn C.IsModelAnimationValid(model C.Model, anim C.ModelAnimation) bool

// Check collision between two spheres
pub fn C.CheckCollisionSpheres(center1 C.Vector3, radius1 f32, center2 C.Vector3, radius2 f32) bool

// Check collision between two bounding boxes
pub fn C.CheckCollisionBoxes(box1 C.BoundingBox, box2 C.BoundingBox) bool

// Check collision between box and sphere
pub fn C.CheckCollisionBoxSphere(box C.BoundingBox, center C.Vector3, radius f32) bool

// Get collision info between ray and sphere
pub fn C.GetRayCollisionSphere(ray C.Ray, center C.Vector3, radius f32) C.RayCollision

// Get collision info between ray and box
pub fn C.GetRayCollisionBox(ray C.Ray, box C.BoundingBox) C.RayCollision

// Get collision info between ray and mesh
pub fn C.GetRayCollisionMesh(ray C.Ray, mesh C.Mesh, transform C.Matrix) C.RayCollision

// Get collision info between ray and triangle
pub fn C.GetRayCollisionTriangle(ray C.Ray, p1 C.Vector3, p2 C.Vector3, p3 C.Vector3) C.RayCollision

// Get collision info between ray and quad
pub fn C.GetRayCollisionQuad(ray C.Ray, p1 C.Vector3, p2 C.Vector3, p3 C.Vector3, p4 C.Vector3) C.RayCollision

// Initialize audio device and context
pub fn C.InitAudioDevice() 

// Close the audio device and context
pub fn C.CloseAudioDevice() 

// Check if audio device has been initialized successfully
pub fn C.IsAudioDeviceReady() bool

// Set master volume (listener)
pub fn C.SetMasterVolume(volume f32) 

// Get master volume (listener)
pub fn C.GetMasterVolume() f32

// Load wave data from file
pub fn C.LoadWave(fileName &char) C.Wave

// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
pub fn C.LoadWaveFromMemory(fileType &char, fileData &C.const unsigned char, dataSize i32) C.Wave

// Checks if wave data is valid (data loaded and parameters)
pub fn C.IsWaveValid(wave C.Wave) bool

// Load sound from file
pub fn C.LoadSound(fileName &char) C.Sound

// Load sound from wave data
pub fn C.LoadSoundFromWave(wave C.Wave) C.Sound

// Create a new sound that shares the same sample data as the source sound, does not own the sound data
pub fn C.LoadSoundAlias(source C.Sound) C.Sound

// Checks if a sound is valid (data loaded and buffers initialized)
pub fn C.IsSoundValid(sound C.Sound) bool

// Update sound buffer with new data
pub fn C.UpdateSound(sound C.Sound, data voidptr, sampleCount i32) 

// Unload wave data
pub fn C.UnloadWave(wave C.Wave) 

// Unload sound
pub fn C.UnloadSound(sound C.Sound) 

// Unload a sound alias (does not deallocate sample data)
pub fn C.UnloadSoundAlias(alias C.Sound) 

// Export wave data to file, returns true on success
pub fn C.ExportWave(wave C.Wave, fileName &char) bool

// Export wave sample data to code (.h), returns true on success
pub fn C.ExportWaveAsCode(wave C.Wave, fileName &char) bool

// Play a sound
pub fn C.PlaySound(sound C.Sound) 

// Stop playing a sound
pub fn C.StopSound(sound C.Sound) 

// Pause a sound
pub fn C.PauseSound(sound C.Sound) 

// Resume a paused sound
pub fn C.ResumeSound(sound C.Sound) 

// Check if a sound is currently playing
pub fn C.IsSoundPlaying(sound C.Sound) bool

// Set volume for a sound (1.0 is max level)
pub fn C.SetSoundVolume(sound C.Sound, volume f32) 

// Set pitch for a sound (1.0 is base level)
pub fn C.SetSoundPitch(sound C.Sound, pitch f32) 

// Set pan for a sound (0.5 is center)
pub fn C.SetSoundPan(sound C.Sound, pan f32) 

// Copy a wave to a new wave
pub fn C.WaveCopy(wave C.Wave) C.Wave

// Crop a wave to defined frames range
pub fn C.WaveCrop(wave &C.Wave, initFrame i32, finalFrame i32) 

// Convert wave data to desired format
pub fn C.WaveFormat(wave &C.Wave, sampleRate i32, sampleSize i32, channels i32) 

// Load samples data from wave as a 32bit float data array
pub fn C.LoadWaveSamples(wave C.Wave) &f32

// Unload samples data loaded with LoadWaveSamples()
pub fn C.UnloadWaveSamples(samples &f32) 

// Load music stream from file
pub fn C.LoadMusicStream(fileName &char) C.Music

// Load music stream from data
pub fn C.LoadMusicStreamFromMemory(fileType &char, data &C.const unsigned char, dataSize i32) C.Music

// Checks if a music stream is valid (context and buffers initialized)
pub fn C.IsMusicValid(music C.Music) bool

// Unload music stream
pub fn C.UnloadMusicStream(music C.Music) 

// Start music playing
pub fn C.PlayMusicStream(music C.Music) 

// Check if music is playing
pub fn C.IsMusicStreamPlaying(music C.Music) bool

// Updates buffers for music streaming
pub fn C.UpdateMusicStream(music C.Music) 

// Stop music playing
pub fn C.StopMusicStream(music C.Music) 

// Pause music playing
pub fn C.PauseMusicStream(music C.Music) 

// Resume playing paused music
pub fn C.ResumeMusicStream(music C.Music) 

// Seek music to a position (in seconds)
pub fn C.SeekMusicStream(music C.Music, position f32) 

// Set volume for music (1.0 is max level)
pub fn C.SetMusicVolume(music C.Music, volume f32) 

// Set pitch for a music (1.0 is base level)
pub fn C.SetMusicPitch(music C.Music, pitch f32) 

// Set pan for a music (0.5 is center)
pub fn C.SetMusicPan(music C.Music, pan f32) 

// Get music time length (in seconds)
pub fn C.GetMusicTimeLength(music C.Music) f32

// Get current music time played (in seconds)
pub fn C.GetMusicTimePlayed(music C.Music) f32

// Load audio stream (to stream raw audio pcm data)
pub fn C.LoadAudioStream(sampleRate u32, sampleSize u32, channels u32) C.AudioStream

// Checks if an audio stream is valid (buffers initialized)
pub fn C.IsAudioStreamValid(stream C.AudioStream) bool

// Unload audio stream and free memory
pub fn C.UnloadAudioStream(stream C.AudioStream) 

// Update audio stream buffers with data
pub fn C.UpdateAudioStream(stream C.AudioStream, data voidptr, frameCount i32) 

// Check if any audio stream buffers requires refill
pub fn C.IsAudioStreamProcessed(stream C.AudioStream) bool

// Play audio stream
pub fn C.PlayAudioStream(stream C.AudioStream) 

// Pause audio stream
pub fn C.PauseAudioStream(stream C.AudioStream) 

// Resume audio stream
pub fn C.ResumeAudioStream(stream C.AudioStream) 

// Check if audio stream is playing
pub fn C.IsAudioStreamPlaying(stream C.AudioStream) bool

// Stop audio stream
pub fn C.StopAudioStream(stream C.AudioStream) 

// Set volume for audio stream (1.0 is max level)
pub fn C.SetAudioStreamVolume(stream C.AudioStream, volume f32) 

// Set pitch for audio stream (1.0 is base level)
pub fn C.SetAudioStreamPitch(stream C.AudioStream, pitch f32) 

// Set pan for audio stream (0.5 is centered)
pub fn C.SetAudioStreamPan(stream C.AudioStream, pan f32) 

// Default size for new audio streams
pub fn C.SetAudioStreamBufferSizeDefault(size i32) 

// Audio thread callback to request new data
pub fn C.SetAudioStreamCallback(stream C.AudioStream, callback C.AudioCallback) 

// Attach audio stream processor to stream, receives the samples as 'float'
pub fn C.AttachAudioStreamProcessor(stream C.AudioStream, processor C.AudioCallback) 

// Detach audio stream processor from stream
pub fn C.DetachAudioStreamProcessor(stream C.AudioStream, processor C.AudioCallback) 

// Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'
pub fn C.AttachAudioMixedProcessor(processor C.AudioCallback) 

// Detach audio stream processor from the entire audio pipeline
pub fn C.DetachAudioMixedProcessor(processor C.AudioCallback) 
