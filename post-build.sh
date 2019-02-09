#!/bin/bash
SCRIPT_PATH=$(realpath $(dirname $0))

TARGET_DIR=$1

# A hacky way to read BR2_ARCH and set as environment variables
export $(grep "BR2_ARCH=" .config | sed 's/"//g')

cd ${SCRIPT_PATH}/vpmu_controller
# Set up the vpmu-controller env vars depending on architecture
if [[ "$BR2_ARCH" == "arm" ]]; then
    pwd
    echo "${TARGET_DIR}/usr/bin/"
    KERNELDIR_ARM=${BUILD_DIR}/linux-custom make -j$(nproc)
    cp ./vpmu-control-arm ${TARGET_DIR}/usr/bin/
    cp ./vpmu-perf-arm ${TARGET_DIR}/usr/bin/
    cp ./device_driver/vpmu-device-arm.ko ${TARGET_DIR}/usr/lib/vpmu-device.ko
else
    KERNELDIR_X86=${BUILD_DIR}/linux-custom make -j$(nproc)
    cp ./vpmu-control-x86 ${TARGET_DIR}/usr/bin/
    cp ./vpmu-perf-x86 ${TARGET_DIR}/usr/bin
    cp ./device_driver/vpmu-device-x86.ko ${TARGET_DIR}/usr/lib/vpmu-device.ko
fi
