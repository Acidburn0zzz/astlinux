################################################################################
#
# whois
#
################################################################################

WHOIS_VERSION = 5.2.18
WHOIS_SITE = http://ftp.debian.org/debian/pool/main/w/whois
WHOIS_SOURCE = whois_$(WHOIS_VERSION).tar.xz

# take precedence over busybox implementation
WHOIS_DEPENDENCIES = $(if $(BR2_PACKAGE_BUSYBOX),busybox)

define WHOIS_CONFIGURE_CMDS
	# Not all perl's include 'autodie' module
	$(SED) '/^use autodie;/d' $(@D)/make_version_h.pl
endef

define WHOIS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" -C $(@D)
endef

define WHOIS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/whois $(TARGET_DIR)/usr/bin/whois
endef

define WHOIS_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/bin/whois
endef

$(eval $(call GENTARGETS,package,whois))
