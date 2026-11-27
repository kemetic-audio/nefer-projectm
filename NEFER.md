# projectM as built for Nefer

Nefer, by Kemetic, is an Android music visualizer that draws MilkDrop presets
with libprojectM. libprojectM is licensed under the GNU Lesser General Public
License, version 2.1 (see `COPYING` and `LICENSE.txt`). This repository is the complete source
of the libprojectM-4.so that Nefer ships, changes included.

## What it is made of

| Part | Upstream | Commit |
|---|---|---|
| projectM | https://github.com/projectM-visualizer/projectm | `eae22de40144ee8ded92f3c04b93a4c2f82adcc0` |
| projectm-eval (`vendor/projectm-eval`) | https://github.com/projectM-visualizer/projectm-eval | `22fb0cfd8f2dfbcd2b68f2443e7f44e19b32c09a` (1.0.7) |

The branch `nefer` is upstream projectM at that commit, followed by three
commits:

1. **Bring projectm-eval 22fb0cf into the tree:** the submodule is replaced
   by its files, unchanged, so one repository holds everything.
2. **Same picture for the same sound:** fixed seeds instead of
   `std::random_device` and the clock, and a first frame time of 0, so the
   same sound always draws the same picture
   (`nefer/patches/projectm.patch`).
3. **projectm-eval: a way to restart rand():** adds
   `projectm_eval_reset_rand()` (`nefer/patches/projectm-eval.patch`).

The same changes are kept as patches in `nefer/patches`, to apply to a clean
upstream checkout: `projectm.patch` from the projectM folder,
`projectm-eval.patch` from `vendor/projectm-eval`.

## Building

`nefer/build-android.sh <output folder>` builds the library for arm64-v8a
with the same CMake settings Nefer uses (Android NDK r28, API level 24,
Release, shared library, no playlist, SDL UI, C++ interface or tests).
Nefer loads the resulting `libprojectM-4.so` through its C API.

Nefer links libprojectM as a separate shared library, so a library built
from this source, or from a modified copy, can take its place.
