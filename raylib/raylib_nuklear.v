module raylib

#include <raylib-nuklear.h>

#flag -Ic/raylib-nuklear/include
#flag -lraylib_nuke

// Initialize the Nuklear GUI context using raylib's font
pub fn C.InitNuklear(fontSize i32) &C.nk_context                

// Initialize the Nuklear GUI context, with a custom font
pub fn C.InitNuklearEx(font C.Font, fontSize f32) &C.nk_context 

// Loads the default Nuklear font
pub fn C.LoadFontFromNuklear(fontSize i32) C.Font                      

// Update the input state and internal components for Nuklear
pub fn C.UpdateNuklear(ctx &C.nk_context) 

// Update the input state and internal components for Nuklear, with a custom frame time
pub fn C.UpdateNuklearEx(ctx &C.nk_context, deltaTime f32)

// Render the Nuklear GUI on the screen
pub fn C.DrawNuklear(ctx &C.nk_context)      

// Deinitialize the Nuklear context
pub fn C.UnloadNuklear(ctx &C.nk_context) 

// Convert a raylib Color to a Nuklear color object
pub fn C.ColorToNuklear(color C.Color) C.nk_color                 

// Convert a raylib Color to a Nuklear f32ing color
pub fn C.ColorToNuklearF(color C.Color) C.nk_colorf               

// Convert a Nuklear color to a raylib Color
pub fn C.ColorFromNuklear(color C.nk_color) C.Color        

// Convert a Nuklear f32ing color to a raylib Color
pub fn C.ColorFromNuklearF(color C.nk_colorf) C.Color      

// Convert a Nuklear rectangle to a raylib Rectangle
pub fn C.RectangleFromNuklear(ctx &C.nk_context, rect C.nk_rect) C.Rectangle 

// Convert a raylib Rectangle to a Nuklear Rectangle
pub fn C.RectangleToNuklear(ctx &C.nk_context, rect C.Rectangle) C.nk_rect 

// Convert a raylib Texture to A Nuklear image
pub fn C.TextureToNuklear(tex C.Texture) C.nk_image               

// Convert a Nuklear image to a raylib Texture
pub fn C.TextureFromNuklear(img C.nk_image) C.Texture      

// Load a Nuklear image
pub fn C.LoadNuklearImage(path &chat) C.nk_image          

// Unload a Nuklear image. And free its data
pub fn C.UnloadNuklearImage(img C.nk_image) 

// Frees the data stored by the Nuklear image
pub fn C.CleanupNuklearImage(img C.nk_image)

// Sets the scaling for the given Nuklear context
pub fn C.SetNuklearScaling(ctx &C.nk_context, scaling f32)

// Retrieves the scaling of the given Nuklear context
pub fn C.GetNuklearScaling(ctx &C.nk_context) f32