#/usr/bin/bash

rm -rf build/

ARCH=$2

x86_64_linux() {
    cmake -B build
    cmake --build build
    mkdir -p dist/x86_64-linux-gnu/bin
    mkdir -p dist/x86_64-linux-gnu/lib
    cp build/liblua5.* dist/x86_64-linux-gnu/lib/
    cp build/lua dist/x86_64-linux-gnu/bin
    cp build/luac dist/x86_64-linux-gnu/bin

    rm -rf build/
}

aarch64_linux() {
    cmake -B build -DCMAKE_TOOLCHAIN_FILE=../toolchains/Aarch64.cmake
    cmake --build build
    mkdir -p dist/aarch64-linux-gnu/bin
    mkdir -p dist/aarch64-linux-gnu/lib
    cp build/liblua5.* dist/aarch64-linux-gnu/lib/
    cp build/lua dist/aarch64-linux-gnu/bin
    cp build/luac dist/aarch64-linux-gnu/bin

    rm -rf build/
}

w64_mingw() {
    cmake -B build -DCMAKE_TOOLCHAIN_FILE=../toolchains/MinGW.cmake
    cmake --build build
    mkdir -p dist/x86_64-w64-mingw32/bin
    mkdir -p dist/x86_64-w64-mingw32/lib
    cp build/liblua5* dist/x86_64-w64-mingw32/lib/
    cp build/*.dll dist/x86_64-w64-mingw32/lib/
    cp build/lua.exe dist/x86_64-w64-mingw32/bin
    cp build/luac.exe dist/x86_64-w64-mingw32/bin

    rm -rf build/
}

wasm32_emscripten() {
    cmake -B build -DCMAKE_TOOLCHAIN_FILE=$HOME/emsdk/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake
    cmake --build build
    mkdir -p dist/wasm32-unknown-emscripten/bin
    mkdir -p dist/wasm32-unknown-emscripten/lib
    cp build/liblua5* dist/wasm32-unknown-emscripten/lib/
    cp build/lua.* dist/wasm32-unknown-emscripten/bin
    cp build/luac.* dist/wasm32-unknown-emscripten/bin

    rm -rf build/
}

armv7_android() {
    cmake -B build \
    -DCMAKE_TOOLCHAIN_FILE=$HOME/android/sdk/ndk/25.1.8937393/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=armeabi-v7a \
    -DANDROID_PLATFORM=android-21

    cmake --build build

    mkdir -p dist/armv7-linux-android/android-21/bin
    mkdir -p dist/armv7-linux-android/android-21/lib
    cp build/liblua5* dist/armv7-linux-android/android-21/lib/
    cp build/lua dist/armv7-linux-android/android-21/bin
    cp build/luac dist/armv7-linux-android/android-21/bin

    rm -rf build/
}

aarch64_android() {
    cmake -B build \
    -DCMAKE_TOOLCHAIN_FILE=$HOME/android/sdk/ndk/25.1.8937393/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=android-21

    cmake --build build

    mkdir -p dist/aarch64-linux-android/android-21/bin
    mkdir -p dist/aarch64-linux-android/android-21/lib
    cp build/liblua5* dist/aarch64-linux-android/android-21/lib/
    cp build/lua dist/aarch64-linux-android/android-21/bin
    cp build/luac dist/aarch64-linux-android/android-21/bin

    rm -rf build/
}

i386_android() {
    cmake -B build \
    -DCMAKE_TOOLCHAIN_FILE=$HOME/android/sdk/ndk/25.1.8937393/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=x86 \
    -DANDROID_PLATFORM=android-21

    cmake --build build

    mkdir -p dist/i386-linux-android/android-21/bin
    mkdir -p dist/i386-linux-android/android-21/lib
    cp build/liblua5* dist/i386-linux-android/android-21/lib/
    cp build/lua dist/i386-linux-android/android-21/bin
    cp build/luac dist/i386-linux-android/android-21/bin

    rm -rf build/
}

x86_64_android() {
    cmake -B build \
    -DCMAKE_TOOLCHAIN_FILE=$HOME/android/sdk/ndk/25.1.8937393/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=x86_64 \
    -DANDROID_PLATFORM=android-21

    cmake --build build

    mkdir -p dist/x86_64-linux-android/android-21/bin
    mkdir -p dist/x86_64-linux-android/android-21/lib
    cp build/liblua5* dist/x86_64-linux-android/android-21/lib/
    cp build/lua dist/x86_64-linux-android/android-21/bin
    cp build/luac dist/x86_64-linux-android/android-21/bin

    rm -rf build/
}

build_lua() {
    case $1 in
    'x86_64_linux' ) x86_64_linux ;;
    'aarch64_linux' ) x86_64_linux ;;
    'i386_android' ) i386_android ;;
    'x86_64_android' ) x86_64_android ;;
    'aarch64_android' ) aarch64_android ;;
    'armv7_android' ) armv7_android ;;
    'aarch64_linux' ) aarch64_linux ;;
    'wasm32_emscripten' ) wasm32_emscripten ;;
    'w64_mingw' ) w64_mingw ;;
    'all' )
        x86_64_linux
        aarch64_linux
        aarch64_android
        wasm32_emscripten
        w64_mingw
        break;;
    esac
}

build_lua $1