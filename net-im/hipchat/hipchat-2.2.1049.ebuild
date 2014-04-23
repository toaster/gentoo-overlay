# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="HipChat client"
HOMEPAGE="http://www.hipchat.com"
SRC_URI="${SRC_URI}
	amd64? ( http://downloads.hipchat.com/linux/arch/x86_64/${P}-x86_64.pkg.tar.xz )
	x86? ( http://downloads.hipchat.com/linux/arch/i686/${P}-i686.pkg.tar.xz )"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	<x11-libs/libxcb-1.10
	"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
	cd -
}

src_prepare() {
	epatch "${FILESDIR}/desktop.patch"
	mkdir -p "usr/share/pixmaps"
	cd "usr/share/pixmaps"
	ln -s ../icons/hicolor/128x128/apps/hipchat.png .
}

src_install() {
	rsync -a ${S}/* ${D}/
}
