#!/bin/bash
SCRIPT_PATH=$(realpath $(dirname $0))

ver=2018.11
wget https://buildroot.org/downloads/buildroot-${ver}.tar.gz
tar -xf buildroot-${ver}.tar.gz
cd ${SCRIPT_PATH}/buildroot-${ver}
cp ../config-buildroot-${ver} ./.config
make
cp ./output/images/* ${SCRIPT_PATH}
# Remove redundant copies
rm ${SCRIPT_PATH}/*.ext2
