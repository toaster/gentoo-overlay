# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit lua

DESCRIPTION="Database connectivity for the Lua programming language"
HOMEPAGE="http://www.keplerproject.org/luasql/"
SRC_URI="https://github.com/downloads/keplerproject/luasql/${P}.tar.gz"

LICENSE="Kepler"
SLOT="0"
KEYWORDS="~x86 ~amd64"

# we don't support unixODBC and Oracle databases yet
MODULES="sqlite sqlite3 mysql postgres"
IUSE="doc ${MODULES}"

DEPEND="
	dev-lang/lua
	sqlite? ( dev-db/sqlite:0 )
	sqlite3? ( dev-db/sqlite:3 )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-base )"

src_prepare(){
	if use mysql; then
		sed -i -e 's#"mysql.h"#<mysql/mysql.h>#' src/ls_mysql.c \
			|| die "sed failed."
	fi
}

src_compile(){
	local libs

	for mod in ${MODULES}; do
		if use ${mod}; then
			einfo "building ${mod} module"

			[ ${mod} == sqlite ] && libs="-lsqlite"
			[ ${mod} == sqlite3 ] && libs="-lsqlite3"
			[ ${mod} == mysql ] && libs="-lmysqlclient -lz"
			[ ${mod} == postgres ] && libs="-lpq"

			emake T=${mod} \
				LUA_VERSION_NUM=${LUAVER_MAJOR}0${LUAVER_MINOR} \
				CFLAGS="${CFLAGS} -fPIC" \
				DRIVER_LIBS=${libs}
		fi
	done
}

src_install(){
	for mod in ${MODULES}; do
		if use ${mod}; then
			lua_install_cmodule src/${mod}.so ${PN}
		fi
	done
	use doc && dohtml -r doc/*
}
