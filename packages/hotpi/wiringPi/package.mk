################################################################################
#      This file is part of DeKockBlock - http://www.dekockblock.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@dekockblock.tv)
#
#  DeKockBlock is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  DeKockBlock is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with DeKockBlock.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="wiringPi"
PKG_VERSION="2.26"
PKG_REV="1"
PKG_PROJECT="RPi"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/shaun2029/wiringPi"
PKG_URL="https://github.com/shaun2029/wiringPi/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
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
}

make_target() {
    ./build static
}

makeinstall_target() {
    mkdir -p $INSTALL/usr/bin
    cp gpio/gpio $INSTALL/usr/bin/
    cp gpio/pintest $INSTALL/usr/bin/
}



