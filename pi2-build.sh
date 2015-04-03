#!/bin/sh
echo "Building for ARM ..."
export CCACHE_DIR=/media/Data/Temp/ccache-dekockblock-pi
export CONCURRENCY_MAKE_LEVEL=8
PROJECT=RPi2 ARCH=arm make release

