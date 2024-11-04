#!/bin/bash

# Oplus camera
CAM=device/oplus/camera/camera.mk
if ! [ -a $CAM ]; then
    git clone https://gitlab.com/nattolecats/android_device_oplus_camera device/oplus/camera
fi

# Clang
CLANG17=prebuilts/clang/host/linux-x86/clang-r487747/bin/clang
if ! [ -a $CLANG17 ]; then
    git clone https://gitlab.com/nattolecats/android_prebuilts_clang_host_linux-x86_clang-r487747 prebuilts/clang/host/linux-x86/clang-r487747 --depth 1
fi

# Make sure KSU init properly
cd kernel/oplus/mt6893 && git submodule update --init && cd -

# Source patches
bash device/oplus/mt6893-common/patches/apply.sh
