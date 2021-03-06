#############################################################
#
# sudo
#
#############################################################

SUDO_VERSION = 1.8.21p2
SUDO_SITE = http://www.sudo.ws/sudo/dist

# This is to avoid sudo's make install from chown()ing files which fails
SUDO_INSTALL_TARGET_OPT = INSTALL_OWNER="" DESTDIR="$(TARGET_DIR)" install

SUDO_CONF_OPT = \
	--without-lecture \
	--without-sendmail \
	--without-umask \
	--with-logging=syslog \
	--without-interfaces \
	--without-pam \
	--without-ldap \
	--with-env-editor

# mksigname/mksiglist needs to run on build host to generate source files
define SUDO_BUILD_MKSIGNAME_MKSIGLIST_HOST
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_CONFIGURE_OPTS) \
		CPPFLAGS="$(HOST_CPPFLAGS) -I../../include -I../.." \
		-C $(@D)/lib/util mksigname mksiglist
endef

SUDO_POST_CONFIGURE_HOOKS += SUDO_BUILD_MKSIGNAME_MKSIGLIST_HOST

$(eval $(call AUTOTARGETS,package,sudo))
