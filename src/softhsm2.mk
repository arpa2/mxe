# This file is part of MXE.
# See index.html for further information.

PKG             := softhsm2
$(PKG)_VERSION  := 2.5.0
$(PKG)_CHECKSUM := 92aa56cf45e25892326e98b851c44de9cac8559e208720e579bf8e2cd1c132b2
$(PKG)_SUBDIR   := softhsm-$($(PKG)_VERSION)
$(PKG)_FILE     := softhsm-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://dist.opendnssec.org/source/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc dlfcn-win32 openssl

define $(PKG)_UPDATE
    echo 'TODO: write update script for $(PKG).' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
    mkdir '$(1)/build'
    cd '$(1)/build' && $(TARGET)-cmake .. -DENABLE_ECC=OFF -DENABLE_GOST=OFF -DRUN_AES_KEY_WRAP=0 -DRUN_AES_KEY_WRAP_PAD=0

    $(MAKE) -C '$(1)/build' -j '$(JOBS)' install DESTDIR='$(PREFIX)/$(TARGET)'
endef

