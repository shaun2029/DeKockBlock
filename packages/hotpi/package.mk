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

PKG_NAME="hotpi"
PKG_VERSION="1"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain bash dnsmasq bridge-utils avahi openvpn wiringPi"
PKG_PRIORITY="optional"
PKG_SECTION="networking"
PKG_SHORTDESC="Hotpi includes VPN WiFi Hotspot, RadioGaga (Internet Radio) etc."
PKG_LONGDESC="Hotpi includes VPN WiFi Hotspot, RadioGaga (Internet Radio) etc."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
: # nothing to make here
}

configure_target() {
: # nothing to make here
}

pre_make_target() {
: # nothing to make here
}

make_target() {
: # nothing to make here
}

makeinstall_target() {
  mkdir -p $INSTALL
  cp -RP $PKG_DIR/files/*  $INSTALL/

  mkdir -p $INSTALL/usr/lib/systemd/system
    cp $PKG_DIR/system.d/* $INSTALL/usr/lib/systemd/system
    
}

post_install() {
  enable_service routing.service
  enable_service dnsmasq.service
  enable_service hotspot.service
  enable_service adaway.service
  enable_service switch-monitor.service
  enable_service haveged.service
}


