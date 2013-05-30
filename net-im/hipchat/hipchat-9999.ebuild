# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="HipChat client"
HOMEPAGE="http://www.hipchat.com"
#http://downloads.hipchat.com/linux/arch/x86_64/hipchat-1.96.524-x86_64.pkg.tar.xz
SRC_URI="${SRC_URI}
	amd64? ( http://downloads.hipchat.com/linux/arch/hipchat-x86_64.tar.xz )
	x86? ( http://downloads.hipchat.com/linux/arch/hipchat-i686.tar.xz )"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

