# This file is part of MXE.
# See index.html for further information.

PKG             := tlspool
$(PKG)_VERSION  := 0.21
$(PKG)_CHECKSUM := 8ea645e3325a2021a5bcd47a3df457d3a44ade05f3285c17a5d7e24cb209418d
$(PKG)_SUBDIR   := .
$(PKG)_FILE     := tlspool.tar.gz
$(PKG)_URL      := http://localhost/~manson/$($(PKG)_FILE)
#$(PKG)_DEPS     := gcc pthreads gnutls p11-kit libtasn1 db quick-der ldns
$(PKG)_DEPS     := gcc pthreads gnutls p11-kit libtasn1 db ldns

define $(PKG)_UPDATE
    echo 'TODO: write update script for $(PKG).' >&2;
    echo $($(PKG)_VERSION)
endef

$(PKG)_MAKE_OPTS = \
        PREFIX='$(PREFIX)/$(TARGET)' \
        CROSS_SUFFIX='$(TARGET)-' \
        CC='$(TARGET)-gcc' \
		PKG_CONFIG='$(TARGET)-pkg-config' \
		DLLTOOL='$(TARGET)-dlltool' \
        HOSTCC='$(BUILD_CC)' \
        WINVER=0x0600 \
		SBIN=bin

define $(PKG)_BUILD
    $(MAKE) WITHOUT_KERBEROS=1 -C '$(1)/src' -j '$(JOBS)' install $($(PKG)_MAKE_OPTS)
    $(MAKE) WITHOUT_KERBEROS=1 -C '$(1)/lib' -j '$(JOBS)' install $($(PKG)_MAKE_OPTS)
endef

