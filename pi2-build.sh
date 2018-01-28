#!/bin/sh
echo "Building for ARM ..."
export CCACHE_DIR=/media/Data/Temp/ccache-openelec-pi
export CONCURRENCY_MAKE_LEVEL=`nproc --all`
PROJECT=RPi2 ARCH=arm make release

