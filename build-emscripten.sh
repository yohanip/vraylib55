#!/usr/bin/env bash
set -euo pipefail

v -o main.wasm.c -d emscripten main.v
emcmake cmake . -B build-emscripten
cmake --build build-emscripten