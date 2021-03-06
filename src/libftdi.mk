# This file is part of MXE.
# See index.html for further information.

PKG             := libftdi
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.20
$(PKG)_CHECKSUM := 4bc6ce70c98a170ada303fbd00b8428d8a2c1aa2
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://www.intra2net.com/en/developer/libftdi/download/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc libusb

$(PKG)_MESSAGE  :=*** libftdi is deprecated - please use libftdi1 ***

define $(PKG)_UPDATE
    echo 'Warning: libftdi is deprecated' >&2;
    echo $(libftdi_VERSION)
endef

define $(PKG)_UPDATE_DISABLED
    $(WGET) -q -O- 'http://www.intra2net.com/en/developer/libftdi/download.php' | \
    $(SED) -n 's,.*libftdi-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD_DISABLED
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --build="`config.guess`" \
        --disable-shared \
        --enable-static \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-libftdipp \
        --disable-python-binding \
        --without-examples \
        --without-docs \
        HAVELIBUSB=true
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef

$(PKG)_BUILD_SHARED =
