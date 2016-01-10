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
PKG_VERSION="1.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://sourceforge.net/projects/bridge"
PKG_URL="http://sourceforge.net/projects/bridge/files/bridge/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="networking"
PKG_SHORTDESC="Dnsmasq provides network infrastructure for small networks"
PKG_LONGDESC="Dnsmasq provides a local DNS server for the network, with forwarding of all query types to upstream recursive DNS servers and cacheing of common record types."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
    autoconf -o configure configure.in
    ./configure  --host="$TARGET_ARCH" --prefix=/usr CC="$CC" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" LIBS="$LIBS" CPPFLAGS="$CPPFLAGS"
}

makeinstall_target() {
    mkdir -p $INSTALL/usr
    mkdir -p $INSTALL/usr/sbin
    cp brctl/brctl $INSTALL/usr/sbin/brctl
}

