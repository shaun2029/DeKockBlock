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

PKG_NAME="libshairplay"
PKG_VERSION="6e521c7"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/juhovh/shairplay"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="libshairplay: emulates AirPort Express"
PKG_LONGDESC="libshairPlay emulates an AirPort Express for the purpose of streaming music from iTunes and compatible iPods."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

post_makeinstall_target() {
  mkdir -p $INSTALL/etc/shairplay
    cp -P ../airport.key $INSTALL/etc/shairplay
}
