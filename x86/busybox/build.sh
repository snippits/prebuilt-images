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
cp ./buildroot-${ver}/output/images/bzImage ./x86_64-bzImage
cp ./buildroot-${ver}/output/images/rootfs.tar ./x86_64-rootfs.tar
cp ./buildroot-${ver}/output/images/rootfs.ext4 ./x86_64-rootfs.ext4
