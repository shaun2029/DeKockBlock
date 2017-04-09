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

PKG_NAME="bridge-utils"
PKG_VERSION="1.6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.linuxfromscratch.org/blfs/view/8.0/basicnet/bridge-utils.html"
PKG_URL="https://www.kernel.org/pub/linux/utils/net/bridge-utils/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="networking"
PKG_SHORTDESC="The bridge-utils package contains a utility needed to create and manage bridge devices."
PKG_LONGDESC="The bridge-utils package contains a utility needed to create and manage bridge devices. This is useful in setting up networks for a hosted virtual machine (VM)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
    autoconf -o configure configure.ac
    ./configure  --host="$TARGET_ARCH" --prefix=/usr CC="$CC" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" LIBS="$LIBS" CPPFLAGS="$CPPFLAGS"
}

makeinstall_target() {
    mkdir -p $INSTALL/usr
    mkdir -p $INSTALL/usr/sbin
    cp brctl/brctl $INSTALL/usr/sbin/brctl
}

