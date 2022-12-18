################################################################################
#
# fsverity-utils
#
################################################################################

FSVERITY_UTILS_VERSION = 1.5
FSVERITY_UTILS_SITE = https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git/snapshot
FSVERITY_UTILS_DEPENDENCIES = libopenssl
FSVERITY_UTILS_LICENSE = Copyright 2019 the fsverity-utils authors
FSVERITY_UTILS_LICENSE_FILES = LICENSE

#PKG_CONFIG_PATH="$(STAGING_DIR)/usr/lib/pkgconfig"

FSVERITY_UTILS_ENV = \
		PKGCONF=$(HOST_DIR)/bin/pkg-config \
		CC=$(HOST_DIR)/bin/aarch64-buildroot-linux-gnu-gcc \
		GCC=$(HOST_DIR)/bin/aarch64-buildroot-linux-gnu-gcc

define FSVERITY_UTILS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(FSVERITY_UTILS_ENV)
endef

define FSVERITY_UTILS_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR="$(TARGET_DIR)" $(FSVERITY_UTILS_ENV) install
endef

$(eval $(generic-package))
