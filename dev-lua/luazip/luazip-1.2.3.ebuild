# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit lua versionator

DESCRIPTION="LuaZip is a lightweight Lua extension library used to read files stored inside zip files. The API is very similar to the standard Lua I/O library API."
HOMEPAGE="http://www.keplerproject.org/luazip/index.html"
MY_PV=$(replace_all_version_separators '_')
SRC_URI="https://github.com/luaforge/${PN}/archive/v${MY_PV}.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="
	dev-libs/zziplib
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${PN}-${MY_PV}" "${S}"

	cd "${S}"
	VER="$(lua -v 2>&1 | cut -d ' ' -f2 | sed 's#\.##g')"
	perl -p -e "s#LUA_VERSION_NUM=.*#LUA_VERSION_NUM=${VER}#" -i config
	perl -p -e "s#LUA_DIR=.*#LUA_DIR=$(lua_get_sharedir)#" -i config
	perl -p -e "s#LUA_LIBDIR=.*#LUA_LIBDIR=$(lua_get_libdir)#" -i config
	perl -p -e "s#LUA_INC=.*#LUA_INC=/usr/include#" -i config
	perl -p -e "s#ZZLIB_INC=.*#ZZLIB_INC=/usr/include#" -i config
}

src_install() {
	lua_install_cmodule src/zip.so.${PV}
	dosym zip.so.${PV} $(lua_get_libdir)/zip.so || die "dosym failed"
}

