#!/bin/bash

if [ -z $1 ]; then
    echo "Usage: update-system path/to/system/folder"
    exit 0
fi

echo "Setting up boot system ..."
sudo cp build.OpenELEC-RPi.arm-devel/bcm2835-bootloader-*/start.elf "$1"
sudo cp build.OpenELEC-RPi.arm-devel/bcm2835-bootloader-*/bootcode.bin "$1"
sudo cp target/OpenELEC-RPi.arm-devel-*.kernel /media/shaun/System/kernel.img

if [ ! -f "$1/cmdline.txt" ]; then
  echo "Setting up boot command line ... ABORTED"
  echo "boot=/dev/mmcblk0p1 disk=/dev/mmcblk0p2 ssh quiet" | sudo tee "$1/cmdline.txt"
fi

echo "Copying SYSTEM ..."
sudo cp target/OpenELEC-RPi.arm-devel-*.system "$1/SYSTEM"

exit 0

