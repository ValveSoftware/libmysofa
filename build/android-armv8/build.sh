#! /bin/bash

if [ -z $NDK ]; then
    echo "ERROR: \$NDK must be set to the path to the Android NDK."
    exit 1
fi

echo Using NDK at $NDK.

NDK_MAKE=$NDK/prebuilt/windows-x86_64/bin/make.exe

cmake \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_MAKE_PROGRAM=$NDK_MAKE \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=21 \
    -DANDROID_STL=c++_static \
    -DBUILD_TESTS=FALSE \
    -DBUILD_SHARED_LIBS=FALSE \
    ../..

$NDK_MAKE mysofa-static
