#!/bin/sh
export CCACHE_DIR=/media/Data/Temp/ccache-openelec-pi
export CONCURRENCY_MAKE_LEVEL=10
PROJECT=RPi ARCH=arm make release

