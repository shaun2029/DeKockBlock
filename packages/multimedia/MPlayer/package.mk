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

PKG_NAME="MPlayer"
PKG_VERSION="1.3.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.mplayerhq.hu"
PKG_URL="http://www.mplayerhq.hu/MPlayer/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain yasm:host"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="MPlayer is a free software and open source media player."
PKG_LONGDESC="MPlayer can play a wide variety of media formats and can also save all streamed content to a file."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# configure GPU drivers and dependencies:
  get_graphicdrivers

if [ "$DEBUG" = yes ]; then
  MPLAYER_DEBUG="--enable-debug"
else
  MPLAYER_DEBUG=""
fi

case "$TARGET_ARCH" in
  arm)
      MPLAYER_CPU=""
  ;;
  i?86)
      MPLAYER_CPU=""
  ;;
  x86_64)
      MPLAYER_CPU=""
  ;;
esac

case "$TARGET_FPU" in
  neon*)
      MPLAYER_FPU="--enable-neon"
  ;;
  vfp*)
      MPLAYER_FPU=""
  ;;
  *)
      MPLAYER_FPU=""
  ;;
esac

pre_configure_target() {
  cd $ROOT/$PKG_BUILD
  rm -rf .$TARGET_NAME

  export pkg_config="$ROOT/$TOOLCHAIN/bin/pkg-config"

# ffmpeg fails building with LTO support
  strip_lto

# ffmpeg fails running with GOLD support
  strip_gold
}

configure_target() {
  ./configure --prefix=/usr \
              --enable-cross-compile \
              --prefix="$SYSROOT_PREFIX" \
              --target="arm-linux" \
              --nm="$NM" \
              --ar="$AR" \
              --as="$CC" \
              --cc="$CC" \
              --extra-cflags="$CFLAGS" \
              --extra-ldflags="$LDFLAGS" \
              --disable-mencoder \
              --disable-iconv \
              --disable-tv \
              --disable-tv-v4l1 \
              --disable-tv-v4l2 \
              --disable-smb \
              $MPLAYER_FPU \
              $MPLAYER_DEBUG
}

makeinstall_target() {
    mkdir -p $INSTALL/usr/bin
    cp mplayer $INSTALL/usr/bin
    
}

