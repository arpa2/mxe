# This file is part of MXE.
# See index.html for further information.

PKG             := quick-der
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2-5
$(PKG)_CHECKSUM := 85cebabd007b79482f1fff64f126daa9be9b5779be35adff9beac96cd5dbfebb
$(PKG)_SUBDIR   := quick-der-version-1.2-5
$(PKG)_FILE     := quick-der.tar.gz
$(PKG)_URL	    := http://localhost/~manson/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc asn2quickder

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://github.com/vanrein/quick-der/tags' | \
    grep '<a href="/vanrein/quick-der/archive/' | \
    $(SED) -n 's,.*href="/vanrein/quick-der/archive/version-\([0-9][^"]*\)\.tar.*,\1,p' | \
    head -1
endef

$(PKG)_MAKE_OPTS = \
	PREFIX='$(PREFIX)/$(TARGET)' \
	CROSS_SUFFIX='$(TARGET)-' \
	CC='$(TARGET)-gcc' \
	AR='$(TARGET)-ar' \
	ASN2QUICKDER_CMD='$(PREFIX)/$(BUILD)/bin/asn2quickder' \
	HOSTCC='$(BUILD_CC)' \
    WINVER=0x0600 \
	EXTRALIBS='-lmsvcrt'

define $(PKG)_BUILD
    mkdir '$(1)/build'
    cd '$(1)/build' && $(TARGET)-cmake .. -DNO_TESTING:BOOL=ON -DARPA2CM_DIR:PATH=$(PREFIX)/$(TARGET)

    $(MAKE) -C '$(1)/build' -j '$(JOBS)' install
endef

