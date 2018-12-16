#!/bin/bash
SCRIPT_PATH=$(realpath $(dirname $0))

ver=2018.11
tarfile=${SCRIPT_PATH}/../../buildroot-${ver}.tar.gz
if [[ ! -f $tarfile ]]; then
    ( cd ${SCRIPT_PATH}/../.. && wget https://buildroot.org/downloads/buildroot-${ver}.tar.gz )
fi
tar -xf $tarfile
cd ${SCRIPT_PATH}/buildroot-${ver}
cp ../config-buildroot-${ver} ./.config
make

# Copy and rename the generated files
cd ${SCRIPT_PATH}
cp ./buildroot-${ver}/output/images/vexpress-v2p-ca9.dtb ./vexpress-v2p-ca9.dtb
cp ./buildroot-${ver}/output/images/zImage ./vecpress-zImage
cp ./buildroot-${ver}/output/images/rootfs.tar ./vexpress-rootfs.tar
cp ./buildroot-${ver}/output/images/rootfs.ext4 ./vexpress-rootfs.ext4
