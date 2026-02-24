module main

import raylib

$if emscripten ? {
	#include <emscripten.h>
}

@[if emscripten ?]
fn C.emscripten_set_main_loop_arg(func fn (voidptr), data voidptr, fps i32, simulate_infinite_loop bool)

struct MyData {
	nk &C.nk_context = unsafe {nil}
}

fn main() {
	C.SetTargetFPS(60)
	C.InitWindow(300, 300, &char(c'v factory'))

	my_data := &MyData{
		nk: C.InitNuklear(18)
	}

	$if emscripten ? {
		C.emscripten_set_main_loop_arg(update, voidptr(my_data), 0, 1)
	} $else {
		for !C.WindowShouldClose() {
			update(my_data)
		}

		C.UnloadNuklear(my_data.nk)
		C.CloseWindow()
	}
}

fn update(udata voidptr) {
	mut mydata := unsafe { &MyData(udata) }

	C.UpdateNuklear(mydata.nk)
	C.BeginDrawing()
	{
		C.ClearBackground(raylib.raywhite)
		C.DrawText(&char(c'Hello, world!'), 0, 20, 20, raylib.red)
		C.DrawFPS(0, 0)

		C.DrawNuklear(mydata.nk)
	}
	C.EndDrawing()
}