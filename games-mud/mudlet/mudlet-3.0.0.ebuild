# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games qmake-utils

DESCRIPTION="Mudlet is a quality MUD client, designed to take mudding to a new level."
HOMEPAGE="http://www.mudlet.org"
MY_PN="Mudlet"
MY_P="${MY_PN}-3.0.0"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	app-text/hunspell
	dev-lang/lua
	dev-libs/libzip
	dev-libs/yajl
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/designer:5
	sys-libs/zlib
	virtual/glu
"
RDEPEND="${DEPEND}
	dev-lua/lrexlib[pcre]
	dev-lua/luazip
	dev-lua/luafilesystem
	dev-lua/luasql[sqlite3]
"

src_configure() {
	epatch "${FILESDIR}/src_pro-3.0.0.patch"
	eqmake5 "${S}/src/src.pro" INSTALL_PREFIX=${INSTALL_PREFIX}
}

src_install() {
	emake DESTDIR="${D}" INSTALL_ROOT="${D}" install
	einstalldocs

	domenu mudlet.desktop
	doicon mudlet.svg mudlet.png

	cd "${S}/src/mudlet-lua"
	for dir in lua lua/geyser; do
		insinto "/usr/share/mudlet/${dir}"
		doins $(ls -1 ${dir}/*.lua)
	done
}
