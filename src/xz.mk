# This file is part of MXE.
# See index.html for further information.

PKG             := xz
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 5.2.1
$(PKG)_CHECKSUM := b918b6648076e74f8d7ae19db5ee663df800049e187259faf5eb997a7b974681
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://tukaani.org/xz/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://tukaani.org/xz/' | \
    $(SED) -n 's,.*xz-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-threads \
        --disable-nls
    $(MAKE) -C '$(1)'/src/liblzma -j '$(JOBS)' install
endef
