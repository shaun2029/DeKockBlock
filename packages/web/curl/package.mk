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

# Notes:
# - build curl with OpenSSL support instead GnuTLS support to 
#   work around a long standing bug on Pi where https streams often hang on
#   start. This hang is normally fatal and requires a reboot.
#   see also http://trac.xbmc.org/ticket/14674 .
#   Easiest way to reproduce is to install gdrive addon and play a video from
#   there: http://forum.xbmc.org/showthread.php?tid=177557

# downgraded to 7.37.1 because 7.38/7.39/7.40 is broken
# 7.38 had issues connecting our repository from a
# threaded context.
# 7.39 did not fix a single thing and is used nowhere in
# the wild. If we experience issues we are on our owns
# 7.40 has an issue with ftp thumbs the way Kodi works
# 7.37.1 is the Ubuntu version which works nicely
# Let's bump again when Ubuntu bumps or kodi bumps
# curl is one of the central libs in kodi

PKG_NAME="curl"
PKG_VERSION="7.37.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://curl.haxx.se"
PKG_URL="http://curl.haxx.se/download/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain zlib libressl rtmpdump"
PKG_PRIORITY="optional"
PKG_SECTION="web"
PKG_SHORTDESC="curl: Client and library for (HTTP, HTTPS, FTP, ...) transfers"
PKG_LONGDESC="Curl is a client to get documents/files from or send documents to a server, using any of the supported protocols (HTTP, HTTPS, FTP, FTPS, GOPHER, DICT, TELNET, LDAP or FILE). The command is designed to work without user interaction or any kind of interactivity."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_lib_rtmp_RTMP_Init=yes \
                           ac_cv_header_librtmp_rtmp_h=yes \
                           --disable-debug \
                           --enable-optimize \
                           --enable-warnings \
                           --disable-curldebug \
                           --disable-ares \
                           --enable-largefile \
                           --enable-http \
                           --enable-ftp \
                           --enable-file \
                           --disable-ldap \
                           --disable-ldaps \
                           --enable-rtsp \
                           --enable-proxy \
                           --disable-dict \
                           --disable-telnet \
                           --disable-tftp \
                           --disable-pop3 \
                           --disable-imap \
                           --disable-smtp \
                           --disable-gophper \
                           --disable-manual \
                           --enable-libgcc \
                           --enable-ipv6 \
                           --enable-versioned-symbols \
                           --enable-nonblocking \
                           --enable-threaded-resolver \
                           --enable-verbose \
                           --disable-sspi \
                           --enable-crypto-auth \
                           --enable-cookies \
                           --enable-hidden-symbols \
                           --disable-soname-bump \
                           --with-gnu-ld \
                           --without-krb4 \
                           --without-spnego \
                           --without-gssapi \
                           --with-zlib \
                           --without-egd-socket \
                           --enable-thread \
                           --with-random=/dev/urandom \
                           --without-gnutls \
                           --with-ssl \
                           --without-polarssl \
                           --without-nss \
                           --with-ca-bundle=$SSL_CERTIFICATES/cacert.pem \
                           --without-ca-path \
                           --without-libssh2 \
                           --with-librtmp=$SYSROOT_PREFIX/usr \
                           --without-libidn"

pre_configure_target() {
# link against librt because of undefined reference to 'clock_gettime'
  export LIBS="-lrt -lm -lrtmp"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/curl-config

  sed -e "s:\(['= ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" -i $SYSROOT_PREFIX/usr/bin/curl-config
  mv $SYSROOT_PREFIX/usr/bin/curl-config $ROOT/$TOOLCHAIN/bin
}
