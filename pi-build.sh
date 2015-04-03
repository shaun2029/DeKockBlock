#!/bin/sh
export CCACHE_DIR=/media/Data/Temp/ccache-dekockblock-pi
export CONCURRENCY_MAKE_LEVEL=8
PROJECT=RPi ARCH=arm make release

