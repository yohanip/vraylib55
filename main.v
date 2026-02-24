module main

import raylib

$if emscripten ? {
	#include <emscripten.h>
}

@[if emscripten ?]
fn C.emscripten_set_main_loop(func fn (), fps i32, simulate_infinite_loop bool)

fn main() {
	C.SetTargetFPS(60)
	C.InitWindow(300, 300, &char(c'v factory'))

	$if emscripten ? {
		C.emscripten_set_main_loop(update, 0, 1)
	} $else {
		for !C.WindowShouldClose() {
			update()
		}

		C.CloseWindow()
	}
}

fn update() {
	C.BeginDrawing()
	C.ClearBackground(raylib.raywhite)
	C.DrawText(&char(c'Hello, world!'), 0, 20, 20, raylib.red)
	C.DrawFPS(0, 0)
	C.EndDrawing()
}