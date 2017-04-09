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

PKG_NAME="wget"
PKG_VERSION="1.18"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://ftp.gnu.org"
PKG_URL="http://ftp.gnu.org/gnu/wget/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain yasm:host"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="Bash is installed to /bin/bash.real"
PKG_LONGDESC="Bash is a Unix shell written by Brian Fox for the GNU Project as a free software replacement for the Bourne shell."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
    cd $ROOT/$PKG_BUILD
    ./configure --host=$TARGET_ARCH --with-ssl=openssl
}

makeinstall_target() {
    mkdir -p $INSTALL/bin
    cp src/wget $INSTALL/bin/wget.real
}

