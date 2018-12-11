# This file is part of MXE.
# See index.html for further information.

PKG             := p11-kit
$(PKG)_VERSION  := 0.23.14
$(PKG)_CHECKSUM := 1cb9fa6d237539f25f62f4c3d4ec71a1c8e0772957ec45ec5af92134129e0d70
$(PKG)_SUBDIR   := p11-kit-$($(PKG)_VERSION)
$(PKG)_FILE     := p11-kit-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/p11-glue/p11-kit/releases/download/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc libtasn1 libffi

define $(PKG)_UPDATE
    echo 'TODO: write update script for $(PKG).' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-rpath \
        CPPFLAGS='-DWINVER=0x0600' \
        LIBS='-lws2_32' \
        ac_cv_prog_AR='$(TARGET)-ar'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef
