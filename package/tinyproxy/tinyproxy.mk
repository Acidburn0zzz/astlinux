#############################################################
#
# tinyproxy
#
#############################################################
TINYPROXY_VERSION = 1.8.4
TINYPROXY_SITE = https://github.com/tinyproxy/tinyproxy/releases/download/$(TINYPROXY_VERSION)
TINYPROXY_SOURCE = tinyproxy-$(TINYPROXY_VERSION).tar.bz2

# Workaround for missing a2x on host, disables docs
TINYPROXY_CONF_ENV = \
	ac_cv_path_A2X=/bin/true

TINYPROXY_CONF_OPT = \
        --enable-filter \
        --enable-reverse \
        --enable-transparent \
        --disable-regexcheck

define TINYPROXY_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/src/tinyproxy $(TARGET_DIR)/usr/sbin/
	-mkdir $(TARGET_DIR)/usr/share/tinyproxy
	cp -a $(@D)/data/templates/*.html $(TARGET_DIR)/usr/share/tinyproxy/
	$(MAKE) DESTDIR=$(TARGET_DIR) -C $(@D)/data/templates install
	$(INSTALL) -D -m 0644 $(@D)/etc/tinyproxy.conf $(TARGET_DIR)/stat/etc/
	$(INSTALL) -D -m 0755 package/tinyproxy/tinyproxy.init $(TARGET_DIR)/etc/init.d/tinyproxy
	ln -sf /tmp/etc/tinyproxy.conf $(TARGET_DIR)/etc/tinyproxy.conf
	ln -sf ../../init.d/tinyproxy $(TARGET_DIR)/etc/runlevels/default/S33tinyproxy
	ln -sf ../../init.d/tinyproxy $(TARGET_DIR)/etc/runlevels/default/K25tinyproxy	
endef

define TINYPROXY_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/sbin/tinyproxy
	rm -rf $(TARGET_DIR)/usr/share/tinyproxy
	rm -f $(TARGET_DIR)/stat/etc/tinyproxy.conf
	rm -f $(TARGET_DIR)/etc/init.d/tinyproxy
	rm -f $(TARGET_DIR)/etc/tinyproxy.conf
	rm -f $(TARGET_DIR)/etc/runlevels/default/S33tinyproxy
	rm -f $(TARGET_DIR)/etc/runlevels/default/K25tinyproxy	
endef

define TINYPROXY_UNINSTALL_STAGING_CMDS
        @echo "Skip Staging Uninstall..."
endef


$(eval $(call AUTOTARGETS,package,tinyproxy))
