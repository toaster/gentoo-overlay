# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-r3 autotools-utils autotools

MY_PN="mpDris2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="MPRIS V2.1 support for mpd"
HOMEPAGE="https://github.com/eonpatapon/mpDris2"
SRC_URI=""

EGIT_REPO_URI="https://github.com/toaster/${MY_PN}"
EGIT_BRANCH="dev"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="mutagen notify"

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-lang/python-2.7.0
	>=dev-python/python-mpd-0.5.1
	notify? ( dev-python/notify-python )
	mutagen? ( media-libs/mutagen )
"

src_prepare() {
	eautoreconf
}
