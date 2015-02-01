# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit gnome2-utils cmake-utils

DESCRIPTION="A tesseract OCR front-end"
HOMEPAGE="https://github.com/manisandro/gImageReader"
SRC_URI="https://github.com/manisandro/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# TODO Gtk / QT → adjust DEPEND
# TODO sane optional → adjust DEPEND
IUSE=""

S="${WORKDIR}/gImageReader-${PV}"

DEPEND="
	dev-util/cmake
	dev-cpp/gtkmm:3.0
	dev-cpp/gtkspellmm
	dev-cpp/cairomm
	app-text/poppler
	app-text/tesseract
	dev-util/intltool
	dev-util/desktop-file-utils
	dev-libs/appstream-glib
	media-gfx/sane-backends
"
RDEPEND="
	${DEPEND}
"

src_configure() {
	local mycmakeargs=(
		-D INTERFACE_TYPE:string=gtk
	)

	cmake-utils_src_configure
}

pkg_preinst() {
    gnome2_icon_savelist
    gnome2_schemas_savelist
}

pkg_postinst() {
    gnome2_icon_cache_update
    gnome2_schemas_update
}

pkg_postrm() {
    gnome2_icon_cache_update
    gnome2_schemas_update
}

