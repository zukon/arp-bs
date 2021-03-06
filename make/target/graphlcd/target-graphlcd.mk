#
# AR-P buildsystem smart Makefile
#
package[[ target_graphlcd

BDEPENDS_${P} = $(target_glibc) $(target_freetype)

PV_${P} = git
PR_${P} = 2

call[[ base ]]

rule[[
  git://projects.vdr-developer.org/${PN}-base.git;b=touchcol
  patch:file://${PN}.patch
  patch:file://${PN}_add_dynload_support.patch
  patch:file://${PN}_support_libusb1.0.patch
]]rule

call[[ git ]]

call[[ base_do_prepare ]]

$(TARGET_${P}).do_compile: $(TARGET_${P}).do_prepare
	cd $(DIR_${P}) && \
		export TARGET=$(target)- && \
		export LDFLAGS="-L$(targetprefix)/usr/lib -Wl,-rpath-link,$(targetprefix)/usr/lib" && \
	$(BUILDENV) \
	$(run_make) all DESTDIR=$(targetprefix)
	touch $@

$(TARGET_${P}).do_package: $(TARGET_${P}).do_compile
	$(PKDIR_clean)
	install -d $(PKDIR)/etc
	cd $(DIR_${P}) && $(run_make) install DESTDIR=$(PKDIR)
	touch $@

call[[ ipk ]]

PACKAGES_${P} = graphlcd_tools graphlcd_config libgraphlcd
DESCRIPTION_${P} = Driver and Tools for LCD4LINUX
FILES_graphlcd_tools = /usr/bin/*
RDEPENDS_graphlcd_tools = libgraphlcd
FILES_libgraphlcd = /usr/lib/libglcddrivers.so.* \
/usr/lib/libglcdgraphics.so.* \
/usr/lib/libglcdskin.so.*
RDEPENDS_libgraphlcd = libusb-1.0 graphlcd_config
define postinst_libgraphlcd
#!/bin/sh
$$OPKG_OFFLINE_ROOT/sbin/ldconfig
endef

FILES_graphlcd_config = /etc/graphlcd.conf

call[[ ipkbox ]]

]]package
