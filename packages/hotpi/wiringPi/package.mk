################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="wiringPi"
PKG_VERSION="2.44"
PKG_REV="1"
PKG_PROJECT="RPi"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/shaun2029/wiringPi"
PKG_URL="https://github.com/shaun2029/wiringPi/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain bash"
PKG_PRIORITY="optional"
PKG_SECTION="utility"
PKG_SHORTDESC="WiringPi provides is a GPIO for the Raspberry Pi."
PKG_LONGDESC="WiringPi is a GPIO access library written in C for the BCM2835 used in the Raspberry Pi."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  export LD="$TARGET_LD"
  export LDFLAGS="$TARGET_LDFLAGS"
  #export CC="$CC"
}

make_target() {
    ./build
}

makeinstall_target() {
    mkdir -p $INSTALL/usr/lib
    mkdir -p $INSTALL/usr/bin

    cp wiringPi/libwiringPi.so.$PKG_VERSION $INSTALL/usr/lib/libwiringPi.so
    cp devLib/libwiringPiDev.so.$PKG_VERSION $INSTALL/usr/lib/libwiringPiDev.so
    cp gpio/gpio $INSTALL/usr/bin/
    cp gpio/pintest $INSTALL/usr/bin/
}



