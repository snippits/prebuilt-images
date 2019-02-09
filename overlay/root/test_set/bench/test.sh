#!/bin/bash
switch_vpmu_mips -o 0 0 && ./fft.mips 2 64   && switch_vpmu_mips -o 0 1
