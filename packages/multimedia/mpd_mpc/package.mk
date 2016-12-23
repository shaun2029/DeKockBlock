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

# NOTE: This is t6he MPC package for MPD renamed to avoid conflict with existing mpc (math library)

PKG_NAME="mpd_mpc"
PKG_VERSION="0.27"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://ftp.gnu.org"
PKG_URL="https://www.immutablefix.co.uk/OpenELEC-HotPi/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libmpdclient"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="A minimalist command line interface to MPD."
PKG_LONGDESC="A minimalist command line interface to MPD."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
    cd $ROOT/$PKG_BUILD
    
    export LIBMPDCLIENT_LIBS=$SYSROOT_PREFIX/usr/lib/libmpdclient.so LIBMPDCLIENT_CFLAGS=$CFLAGS 
    ./configure --host=$TARGET_ARCH --build=$HOST_NAME --without-PACKAGE
}

makeinstall_target() {
    mkdir -p $INSTALL/usr/bin
    cp src/mpc $INSTALL/usr/bin/
}
