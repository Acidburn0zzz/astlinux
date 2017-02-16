#############################################################
#
# mtr
#
#############################################################
MTR_VERSION = 0.87
MTR_SITE = ftp://ftp.bitwizard.nl/mtr
MTR_SOURCE = mtr-$(MTR_VERSION).tar.gz

MTR_DEPENDENCIES = host-pkg-config ncurses

MTR_CONF_OPT = \
	--without-gtk

define MTR_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 4711 $(@D)/mtr $(TARGET_DIR)/usr/sbin/
endef

define MTR_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/sbin/mtr
endef

$(eval $(call AUTOTARGETS,package,mtr))
