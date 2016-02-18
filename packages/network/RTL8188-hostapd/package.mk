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

PKG_NAME="RTL8188-hostapd"
PKG_VERSION="2.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
# realtek: PKG_SITE="http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PFid=48&Level=5&Conn=4&ProdID=274&DownTypeID=3&GetDown=false&Downloads=true"
PKG_SITE="https://github.com/shaun2029/RTL8188-hostapd"
PKG_URL="https://www.immutablefix.co.uk/OpenELEC-HotPi/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="Hostapd (Host access point daemon)"
PKG_LONGDESC="Hostapd (Host access point daemon) is a user space software access point capable of turning normal network interface cards into access points and authentication servers."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  unset LDFLAGS
#  cp $ROOT/$PKG_BUILD/RTL8188-hostapd-$PKG_VERSION/hostapd/defconfig $ROOT/$PKG_BUILD/hostapd-0.8/hostapd/.config
}

make_target() {
  cd $ROOT/$PKG_BUILD/hostapd
  
  make
}

makeinstall_target() {
   
  mkdir -p $INSTALL/usr/sbin  
    cp $ROOT/$PKG_BUILD/hostapd/hostapd $INSTALL/usr/sbin/
    cp $ROOT/$PKG_BUILD/hostapd/hostapd_cli $INSTALL/usr/sbin/
}
