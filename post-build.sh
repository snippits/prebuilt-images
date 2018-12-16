#!/bin/bash
SCRIPT_PATH=$(realpath $(dirname $0))

TARGET_DIR=$1

# A hacky way to read BR2_ARCH and set as environment variables
export $(grep "BR2_ARCH=" .config | sed 's/"//g')

cd ${SCRIPT_PATH}/vpmu_controller
# Set up the vpmu-controller env vars depending on architecture
if [[ "$BR2_ARCH" == "arm" ]]; then
    KERNELDIR_ARM=${BUILD_DIR}/linux-custom make -j$(nproc)
    cp ./vpmu-control-arm ${TARGET_DIR}/root/
    cp ./vpmu-perf-arm ${TARGET_DIR}/root/
    cp ./profile.sh ${TARGET_DIR}/root/
    cp ./device_driver/vpmu-device-arm.ko ${TARGET_DIR}/root/
else
    KERNELDIR_X86=${BUILD_DIR}/linux-custom make -j$(nproc)
    cp ./vpmu-control-x86 ${TARGET_DIR}/root/
    cp ./vpmu-perf-x86 ${TARGET_DIR}/root/
    cp ./profile.sh ${TARGET_DIR}/root/
    cp ./device_driver/vpmu-device-x86.ko ${TARGET_DIR}/root/
fi
