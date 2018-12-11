# This file is part of MXE.
# See index.html for further information.

PKG             := unbound
$(PKG)_WEBSITE  := https://nlnetlabs.nl/projects/unbound
$(PKG)_DESCR    := unbound
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.8.2
$(PKG)_CHECKSUM := 19f2235a8936d89e7dc919bbfcef355de759f220e36bb5e1e931ac000ed04993
$(PKG)_SUBDIR   := unbound-$($(PKG)_VERSION)
$(PKG)_FILE     := unbound-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://nlnetlabs.nl/downloads/unbound/$($(PKG)_FILE)
# $(PKG)_URL_2    := .../$($(PKG)_FILE)
$(PKG)_DEPS     := gcc openssl zlib expat



define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://unbound.net/downloads/' | \
    grep 'unbound-[0-9]' | \
    $(SED) -n 's,.*unbound-\([0-9][^>]*\)\.tar\.gz.*,\1,p' | \
    grep -v 'rc[0-9]' | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
		$(MXE_CONFIGURE_OPTS) \
		--disable-flto \
		--enable-shared \
		--without-pthreads \
		--with-libexpat=$(PREFIX)/$(TARGET) \
        CFLAGS='-DUB_ON_WINDOWS' \
		LIBS="`'$(TARGET)-pkg-config' openssl --libs`"
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef
