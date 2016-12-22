#!/bin/bash

#Select PROJECT and ARCH to build
if [ "$PROJECT" == "" ]; then
    PROJECT=RPi2
    ARCH=arm
fi

BRANCH=jarvis
BUILDDIR=build-pvr.mythtv-${PROJECT}.${ARCH}


if [ -d "pvr.mythtv" ]; then
    cd "pvr.mythtv"
    git pull
    cd ..
else
    git clone -b $BRANCH https://github.com/janbar/pvr.mythtv.git
fi

# Create a cleaned build folder and go
mkdir -p $BUILDDIR
rm -rf $BUILDDIR/*
cd $BUILDDIR

#Configure the build by running script below
for FILE in \
  ../build.OpenELEC-${PROJECT}.${ARCH}-*/toolchain/etc/cmake-*-openelec-*.conf ; do
  if [ -f "$FILE" ]; then
	cmake -DCMAKE_TOOLCHAIN_FILE=$FILE \
          -DCMAKE_BUILD_TYPE=Release \
          ../pvr.mythtv/
    break
  fi
done

#Build the addon
make -j 4

#Create the package ZIP
cp -r ../pvr.mythtv/pvr.mythtv ./
cp pvr.mythtv.so pvr.mythtv/
zip -r pvr.mythtv-${PROJECT}-${ARCH}.zip ./pvr.mythtv
cd ..

