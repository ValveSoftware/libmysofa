#! /bin/bash

if [ -z $NDK ]; then
    echo "ERROR: \$NDK must be set to the path to the Android NDK."
    exit 1
fi

echo Using NDK at $NDK.

NDK_MAKE=$NDK/prebuilt/windows-x86_64/bin/make.exe

MYSOFA_CMAKE_BUILD_TYPE=Release
if [[ "$MYSOFA_BUILD_DEBUG" == "true" ]]; then
    MYSOFA_CMAKE_BUILD_TYPE=Debug
fi

MYSOFA_BUILD_SHARED_LIBS=FALSE
MYSOFA_TARGET=mysofa-static
if [[ "$MYSOFA_BUILD_SHARED" == "true" ]]; then
    MYSOFA_BUILD_SHARED_LIBS=TRUE
    MYSOFA_TARGET=mysofa-shared
fi

cmake \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=$MYSOFA_CMAKE_BUILD_TYPE \
    -DCMAKE_MAKE_PROGRAM=$NDK_MAKE \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=x86_64 \
    -DANDROID_PLATFORM=21 \
    -DANDROID_STL=c++_static \
    -DBUILD_TESTS=FALSE \
    -DBUILD_SHARED_LIBS=$MYSOFA_BUILD_SHARED_LIBS \
    ../..

$NDK_MAKE $MYSOFA_TARGET
