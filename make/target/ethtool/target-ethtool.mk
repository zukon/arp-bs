#
# AR-P buildsystem smart Makefile
#
package[[ target_ethtool

BDEPENDS_${P} = $(target_glibc)

PV_${P} = 3.4.1
PR_${P} = 1

call[[ base ]]

rule[[
  extract:http://downloads.openwrt.org/sources/${PN}-${PV}.tar.xz
]]rule

call[[ base_do_prepare ]]

$(TARGET_${P}).do_compile: $(TARGET_${P}).do_prepare
	cd $(DIR_${P}) && \
		$(BUILDENV) \
		./configure \
			--build=$(build) \
			--host=$(target) \
			--prefix=/usr \
		&& \
		$(run_make) all
	touch $@

$(TARGET_${P}).do_package: $(TARGET_${P}).do_compile
	$(PKDIR_clean)
	cd $(DIR_${P}) && $(run_make) install DESTDIR=$(PKDIR)
	touch $@

DESCRIPTION_${P} = ethtool
RDEPENDS_${P} = libc6
FILES_${P} = /usr/sbin/*

call[[ ipkbox ]]

]]package
