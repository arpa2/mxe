# This file is part of MXE.
# See index.html for further information.

PKG             := ldns
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.7.0
$(PKG)_CHECKSUM := c19f5b1b4fb374cfe34f4845ea11b1e0551ddc67803bd6ddd5d2a20f0997a6cc
$(PKG)_SUBDIR   := ldns-$($(PKG)_VERSION)
$(PKG)_FILE     := ldns-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://nlnetlabs.nl/downloads/ldns/$($(PKG)_FILE)
# $(PKG)_URL_2    := .../$($(PKG)_FILE)
$(PKG)_DEPS     := gcc openssl

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://nlnetlabs.nl/downloads/' | \
    grep 'ldns-[0-9]' | \
    $(SED) -n 's,.*ldns-\([0-9][^>]*\)\.tar\.gz.*,\1,p' | \
    grep -v 'rc[0-9]' | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
	LIBS="`'$(TARGET)-pkg-config' openssl --libs`"
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef

