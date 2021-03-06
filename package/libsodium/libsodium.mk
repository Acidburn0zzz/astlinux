#############################################################
#
# libsodium
#
#############################################################
LIBSODIUM_VERSION = 1.0.13
LIBSODIUM_SOURCE = libsodium-$(LIBSODIUM_VERSION).tar.gz
LIBSODIUM_SITE = https://github.com/jedisct1/libsodium/releases/download/$(LIBSODIUM_VERSION)

LIBSODIUM_INSTALL_STAGING = YES

LIBSODIUM_CONF_OPT = \
	--enable-minimal

define LIBSODIUM_INSTALL_TARGET_CMDS
	cp -a $(STAGING_DIR)/usr/lib/libsodium.so* $(TARGET_DIR)/usr/lib/
endef

define LIBSODIUM_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/lib/libsodium.so*
endef

$(eval $(call AUTOTARGETS,package,libsodium))
