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

PKG_NAME="hostapd"
PKG_VERSION="2.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
# realtek: PKG_SITE="http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PFid=48&Level=5&Conn=4&ProdID=274&DownTypeID=3&GetDown=false&Downloads=true"
PKG_SITE="https://w1.fi/hostapd/"
PKG_URL="https://w1.fi/releases/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="Hostapd (Host access point daemon)"
PKG_LONGDESC="Hostapd (Host access point daemon) is a user space software access point capable of turning normal network interface cards into access points and authentication servers."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/libnl3 -I$SYSROOT_PREFIX/usr/include/libressl"
  export LIBS="$LIBS -lnl-3 -lnl-genl-3 -lpthread -L$SYSROOT_PREFIX/usr/lib"
#  export LIBS_p="$LIBS_p -L$SYSROOT_PREFIX/usr/local/lib"
#  export LIBS_c="$LIBS_c -L$SYSROOT_PREFIX/usr/local/lib"

}

configure_target() {
  LDFLAGS="$LDFLAGS -lnl-3 -lnl-genl-3 -lpthread"
  cp $PKG_DIR/config/makefile.config hostapd/.config
}

make_target() {
    cd hostapd
    make
}

makeinstall_target() {
   
    mkdir -p $INSTALL/usr/sbin  
    cp $ROOT/$PKG_BUILD/hostapd/hostapd $INSTALL/usr/sbin/
    cp $ROOT/$PKG_BUILD/hostapd/hostapd_cli $INSTALL/usr/sbin/
}
