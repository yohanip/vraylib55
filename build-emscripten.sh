#!/usr/bin/env bash
set -euo pipefail

v -o main.wasm.c -d ems -d no_backtrace -gc none main.v
emcmake cmake . -B build-emscripten -DCMAKE_BUILD_TYPE=Release
cmake --build build-emscripten