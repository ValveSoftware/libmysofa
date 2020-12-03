#! /bin/bash

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
    -G "Visual Studio 14 2015 Win64" \
    -DCMAKE_BUILD_TYPE=$MYSOFA_CMAKE_BUILD_TYPE \
    -DBUILD_TESTS=FALSE \
    -DBUILD_SHARED_LIBS=$MYSOFA_BUILD_SHARED_LIBS \
    ../..

cmake --build . --config $MYSOFA_CMAKE_BUILD_TYPE
