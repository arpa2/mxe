# This file is part of MXE.
# See index.html for further information.

PKG             := muparser
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.2.3
$(PKG)_CHECKSUM := dfe831b69392ab0b1eb59d3601b7b1575554a85057cf2f234f64f930c4148902
$(PKG)_SUBDIR   := $(PKG)_v$(subst .,_,$($(PKG)_VERSION))
$(PKG)_FILE     := $(PKG)_v$(subst .,_,$($(PKG)_VERSION)).zip
$(PKG)_URL      := http://$(SOURCEFORGE_MIRROR)/project/$(PKG)/$(PKG)/Version $($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://sourceforge.net/projects/muparser/files/muparser/' | \
    $(SED) -n 's,.*Version%20\([0-9][^"]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-shared \
        --disable-samples \
        --disable-debug
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef

$(PKG)_BUILD_SHARED =
