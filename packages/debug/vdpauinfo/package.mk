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

PKG_NAME="vdpauinfo"
PKG_VERSION="0.9"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://freedesktop.org/wiki/Software/VDPAU"
PKG_URL="http://people.freedesktop.org/~aplattner/vdpau/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libvdpau"
PKG_PRIORITY="optional"
PKG_SECTION="debug"
PKG_SHORTDESC="vdpauinfo: a tool to show vdpau infos "
PKG_LONGDESC="VDPAU is the Video Decode and Presentation API for UNIX. It provides an interface to video decode acceleration and presentation hardware present in modern GPUs."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"
