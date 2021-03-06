#
# AR-P buildsystem smart Makefile
#
package[[ target_openssl

BDEPENDS_${P} = $(target_glibc) $(target_gcc_lib)

PV_${P} = 1.0.2h
PR_${P} = 4

call[[ base ]]

rule[[
  extract:ftp://ftp.openssl.org/source/${PN}-${PV}.tar.gz
  patch:file://${PN}-1.0.2.patch
]]rule

call[[ base_do_prepare ]]

$(TARGET_${P}).do_compile: $(TARGET_${P}).do_prepare
	cd $(DIR_${P}) && \
		$(BUILDENV) \
		./Configure -DL_ENDIAN shared no-hw linux-generic32 \
			--prefix=/usr \
			--openssldir=/etc/ssl \
		&& \
		$(run_make)
	touch $@

$(TARGET_${P}).do_package: $(TARGET_${P}).do_compile
	$(PKDIR_clean)
	cd $(DIR_${P}) && $(run_make) install INSTALL_PREFIX=$(PKDIR)
	touch $@

call[[ ipk ]]

PACKAGES_${P} =  libcrypto1 libssl1
DESCRIPTION_${P} = Secure Socket Layer (SSL) binary and related cryptographic tools.

FILES_libcrypto1 = /usr/lib/libcrypto.so.*

RDEPENDS_libssl1 = libcrypto1
FILES_libssl1 = /usr/lib/libssl.so.*

call[[ provides_so ]]
call[[ ipkbox ]]

]]package
