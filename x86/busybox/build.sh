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
cp ./output/images/* ${SCRIPT_PATH}
# Remove redundant copies
rm ${SCRIPT_PATH}/*.ext2
