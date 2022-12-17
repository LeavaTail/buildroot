################################################################################
#
# xfsprogs
#
################################################################################

LIBXFSPROGS_VERSION = 5.14.2
LIBXFSPROGS_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/fs/xfs/xfsprogs
LIBXFSPROGS_SOURCE = xfsprogs-$(XFSPROGS_VERSION).tar.xz
LIBXFSPROGS_LICENSE = GPL-2.0, GPL-2.0+, LGPL-2.1 (libhandle, few headers)
LIBXFSPROGS_LICENSE_FILES = LICENSES/GPL-2.0 LICENSES/LGPL-2.1

LIBXFSPROGS_DEPENDENCIES = inih liburcu util-linux

LIBXFSPROGS_CONF_ENV = ac_cv_header_aio_h=yes ac_cv_lib_rt_lio_listio=yes PLATFORM="linux"
LIBXFSPROGS_CONF_OPTS = \
	--enable-lib64=no \
	--enable-gettext=no \
	INSTALL_USER=root \
	INSTALL_GROUP=root \
	--enable-static

ifeq ($(BR2_PACKAGE_ICU),y)
LIBXFSPROGS_DEPENDENCIES += icu
LIBXFSPROGS_CONF_OPTS += --enable-libicu
else
LIBXFSPROGS_CONF_OPTS += --disable-libicu
endif

LIBXFSPROGS_INSTALL_STAGING = YES
LIBXFSPROGS_INSTALL_TARGET = NO

define LIBXFSPROGS_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DIST_ROOT=$(STAGING_DIR) install; \
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DIST_ROOT=$(STAGING_DIR) install-dev
endef

$(eval $(autotools-package))
