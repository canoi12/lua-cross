#/usr/bin/bash

rm -rf build/

cmake -B build
cmake --build build
mkdir -p dist/x86_64-linux-gnu/bin
mkdir -p dist/x86_64-linux-gnu/lib
cp build/liblua5.* dist/x86_64-linux-gnu/lib/
cp build/lua dist/x86_64-linux-gnu/bin
cp build/luac dist/x86_64-linux-gnu/bin

rm -rf build/

cmake -B build -DCMAKE_TOOLCHAIN_FILE=../toolchains/MinGW.cmake
cmake --build build
mkdir -p dist/x86_64-w64-mingw32/bin
mkdir -p dist/x86_64-w64-mingw32/lib
cp build/liblua5* dist/x86_64-w64-mingw32/lib/
cp build/*.dll dist/x86_64-w64-mingw32/lib/
cp build/lua.exe dist/x86_64-w64-mingw32/bin
cp build/luac.exe dist/x86_64-w64-mingw32/bin

rm -rf build/