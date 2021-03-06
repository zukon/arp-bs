#
# Host programs vital for future build
#
package[[ meta_host

BDEPENDS_${P} = \
  $(host_autoconf) $(host_automake) $(host_autotools) $(host_pkg_config) $(host_libtool) \
  $(host_module_init_tools) $(host_mtd_utils) $(host_lndir) $(host_ipkg_utils) $(host_opkg)

call[[ chain ]]

# Note this is kind of ${TARGET}.hold by default. Use this pattern every time you want weak dependency

# If some of host programs is updated
# we will not rebuild all dependent packages by default
${TARGET}: | ${TARGET}.do_depends

# If you decided to clean it, or any package in its ${BDEPENDS}
# we break clean chain here
${TARGET}.clean: ${TARGET}.clean_help
${TARGET}.clean_help:
	@echo
	@echo ----------------------------------------------------------------------------
	@echo Are you shure you want to remove cross and target?
	@echo to remove all data run:
	@echo run make ${TARGET}.clean_childs
	@echo ----------------------------------------------------------------------------

]]package