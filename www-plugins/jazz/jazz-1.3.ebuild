# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils nsplugins

DESCRIPTION="Jazz-Plugin"
HOMEPAGE="http://jazz-soft.net/"

JP_URI="http://jazz-soft.net/download/Jazz-Plugin/${PV}"
JP_32_SO="Jazz-Plugin-32.so"
JP_64_SO="Jazz-Plugin-64.so"

SRC_URI="
	amd64? ( ${JP_URI}/${JP_64_SO}.gz )
	x86? ( ${JP_URI}/${JP_32_SO}.gz )
"
IUSE=""
REQUIRED_USE=""
SLOT="0"
LICENSE=""

KEYWORDS="amd64 x86"

S="${WORKDIR}"

DEPEND=""
RDEPEND="${DEPEND}"

#multilib_src_install() {
#	# PLUGINS_DIR comes from nsplugins.eclass
#	exeinto /usr/$(get_libdir)/${PLUGINS_DIR}
#	doexe libflashplayer.so
#
#	if [[ ${ABI} == amd64 && ${need_lahf_wrapper} ]]; then
#		# This experimental wrapper, from Maks Verver via bug #268336 should
#		# emulate the missing lahf instruction affected platforms.
#		doexe flashplugin-lahf-fix.so
#	fi
#
#	if multilib_is_native_abi; then
#		if use kde; then
#			local pkglibdir=lib
#			[[ -d usr/lib64 ]] && pkglibdir=lib64
#
#			exeinto /usr/$(get_libdir)/kde4
#			doexe usr/${pkglibdir}/kde4/kcm_adobe_flash_player.so
#			insinto /usr/share/kde4/services
#			doins usr/share/kde4/services/kcm_adobe_flash_player.desktop
#		else
#			# No KDE applet, so allow the GTK utility to show up in KDE:
#			sed -i usr/share/applications/flash-player-properties.desktop \
#				-e "/^NotShowIn=KDE;/d" || die "sed of .desktop file failed"
#		fi
#
#		# The userland 'flash-player-properties' standalone app:
#		dobin usr/bin/flash-player-properties
#
#		# Icon and .desktop for 'flash-player-properties'
#		insinto /usr/share
#		doins -r usr/share/{icons,applications}
#		dosym ../icons/hicolor/48x48/apps/flash-player-properties.png \
#			/usr/share/pixmaps/flash-player-properties.png
#	fi
#
#	# The magic config file!
#	insinto "/etc/adobe"
#	doins "${FILESDIR}/mms.cfg"
#}

src_install() {
	insinto /usr/$(get_libdir)/${PLUGINS_DIR}
	if [ ${ABI} == amd64 ]; then
		doins ${JP_64_SO}
	else
		doins ${JP_32_SO}
	fi
}
