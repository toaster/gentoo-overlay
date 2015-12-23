# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils linux-mod git-r3

DESCRIPTION="Reverse engineered Linux driver for the Broadcom 1570 PCIe webcam"
HOMEPAGE="https://github.com/patjak/bcwc_pcie"
SRC_URI=""

EGIT_REPO_URI="https://github.com/patjak/bcwc_pcie"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

BUILD_TARGETS="all"
MODULE_NAMES="facetimehd()"
CONFIG_CHECK="VIDEO_V4L2 VIDEOBUF2_CORE VIDEOBUF2_DMA_SG"

FIRMWARE_PATH="/lib/firmware/facetimehd/firmware.bin"

pkg_postinst() {
	test -f ${FIRMWARE_PATH} || {
		elog "You will need to install the firmware in ${FIRMWARE_PATH}."
		elog "See https://github.com/patjak/bcwc_pcie/wiki/Get-Started for instructions"
		elog "on how to obtain it."
	}
}
