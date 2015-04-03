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

PKG_NAME="wireless-regdb"
PKG_VERSION="2014.11.18"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://wireless.kernel.org/en/developers/Regulatory"
PKG_URL="https://www.kernel.org/pub/software/network/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="wireless-regdb: regulatory database"
PKG_LONGDESC="wireless-regdb is a regulatory database"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing to do
}

makeinstall_target() {
  : # nothing to do
}
