module raylib

pub struct C.nk_context {}
pub struct C.nk_image {}
pub struct C.nk_rect {
    x f32
    y f32
    w f32
    h f32
}
pub struct C.nk_colorf {}
pub struct C.nk_color {}

type C.nk_bool = i32
type C.nk_flags = u32

pub enum Nk_panel_flags as u32 {
    border            = 1 << 0
    moveable          = 1 << 1
    scalable          = 1 << 2
    closeable         = 1 << 3
    minimizeable      = 1 << 4
    no_scrollbar      = 1 << 5
    title             = 1 << 6
    scroll_auto_hide  = 1 << 7
    background        = 1 << 8
    scale_left        = 1 << 9
    no_input          = 1 << 10
}

pub fn C.nk_begin(ctx &C.nk_context, title &char, bounds C.nk_rect, flags C.nk_flags) C.nk_bool
pub fn C.nk_layout_row_static(ctx &C.nk_context, height f32, item_width i32, cols i32)
pub fn C.nk_button_label(ctx &C.nk_context, label &char) C.nk_bool
pub fn C.nk_layout_row_dynamic(ctx &C.nk_context, height f32, cols i32)
pub fn C.nk_option_label(ctx &C.nk_context, label &char, active C.nk_bool) C.nk_bool
pub fn C.nk_layout_row_begin(ctx &C.nk_context, fmt C.k_layout_format, row_height f32, cols i32)
pub fn C.nk_layout_row_end(ctx &C.nk_context)
pub fn C.nk_layout_row_push(ctx &C.nk_context, ratio_or_width f32)
pub fn C.nk_label(ctx &C.nk_context, str &char, alignment nk_flags)
pub fn C.nk_slider_float(ctx &C.nk_context, min f32, val &f32, max f32, step f32) C.nk_bool
pub fn C.nk_window_is_closed(ctx &C.nk_context, name &char) C.nk_bool

pub fn C.nk_end(ctx &C.nk_context)