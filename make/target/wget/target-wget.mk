#
# AR-P buildsystem smart Makefile
#
package[[ target_wget

BDEPENDS_${P} = $(target_openssl)

PV_${P} = 1.17.1
PR_${P} = 1

call[[ base ]]

rule[[
  extract:http://ftp.gnu.org/gnu/${PN}/${PN}-${PV}.tar.gz
  patch:file://${PN}.diff
]]rule

call[[ base_do_prepare ]]

$(TARGET_${P}).do_compile: $(TARGET_${P}).do_prepare
	cd $(DIR_${P}) && \
		$(BUILDENV) \
		./configure \
			--prefix=/ \
			--datarootdir=/usr/share \
			--with-ssl=openssl \
			--disable-nls \
			--disable-debug \
			--without-libssl-prefix \
			--build=$(build) \
			--host=$(target) \
			--target=$(target) \
		&& \
		$(run_make)
	touch $@

$(TARGET_${P}).do_package: $(TARGET_${P}).do_compile
	$(PKDIR_clean)
	cd $(DIR_${P}) && $(run_make) install DESTDIR=$(PKDIR)
	rm -r $(PKDIR)/usr/share/info/dir
	touch $@

call[[ ipk ]]

DESCRIPTION_${P} = GNU Wget is a free network utility to retrieve files from the World Wide Web using HTTP and FTP, the two most widely used Internet protocols.
FILES_${P} = /

call[[ ipkbox ]]

]]package
