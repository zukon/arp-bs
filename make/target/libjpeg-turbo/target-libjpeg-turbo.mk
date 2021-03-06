#
# AR-P buildsystem smart Makefile
#
package[[ target_libjpeg_turbo

BDEPENDS_${P} = $(target_glibc)

PV_${P} = 1.4.2
PR_${P} = 3

PN_${P} = libjpeg-turbo

call[[ base ]]

rule[[
  extract:http://sourceforge.net/projects/${PN}/files/${PN}-${PV}.tar.gz
  patch:file://jpeg.diff
]]rule

call[[ base_do_prepare ]]

$(TARGET_${P}).do_compile: $(TARGET_${P}).do_prepare
	cd $(DIR_${P}) && \
		$(BUILDENV) \
		./configure \
			--build=$(build) \
			--host=$(target) \
			--with-jpeg8 \
			--prefix=/usr \
		&& \
		$(run_make) all
	touch $@

$(TARGET_${P}).do_package: $(TARGET_${P}).do_compile
	$(PKDIR_clean)
	cd $(DIR_${P}) && $(run_make) install DESTDIR=$(PKDIR)
	touch $@

call[[ ipk ]]

NAME_${P} = libjpeg-turbo
DESCRIPTION_${P} = libjpeg contains a library for handling the JPEG (JFIF) image format, as \
 well as related programs for accessing the libjpeg functions.
RDEPENDS_${P} = libc6
FILES_${P} = /usr/lib/*.so.* 

call[[ provides_so ]]
call[[ ipkbox ]]

]]package
