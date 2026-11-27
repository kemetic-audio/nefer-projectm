#!/usr/bin/env bash
#
# Builds libprojectM-4.so for Android arm64-v8a from this tree, with the
# settings Nefer's library is built with.
#
# Run:   nefer/build-android.sh <output folder>
# Needs: cmake 3.22+, ninja, bison 3.8+, flex, and Android NDK r28
#        (28.2.13676358; set ANDROID_NDK to its folder).
# Writes <output folder>/build (the CMake tree) and <output folder>/install
# (include/projectM-4 and lib/libprojectM-4.so).

set -euo pipefail

readonly ROOT="$(cd "$(dirname "$0")/.." && pwd)"
readonly OUT="$(mkdir -p "${1:?usage: nefer/build-android.sh <output folder>}" && cd "$1" && pwd)"
readonly NDK="${ANDROID_NDK:?set ANDROID_NDK to the Android NDK r28 folder}"

cmake -S "$ROOT" -B "$OUT/build" -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE="$NDK/build/cmake/android.toolchain.cmake" \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=android-24 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$OUT/install" \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_TESTING=OFF \
    -DBUILD_DOCS=OFF \
    -DENABLE_PLAYLIST=OFF \
    -DENABLE_SDL_UI=OFF \
    -DENABLE_CXX_INTERFACE=OFF \
    -DENABLE_BOOST_FILESYSTEM=OFF \
    -DENABLE_SYSTEM_GLM=OFF \
    -DENABLE_SYSTEM_PROJECTM_EVAL=OFF
cmake --build "$OUT/build"
cmake --install "$OUT/build"
