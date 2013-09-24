# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils qt4-r2
MY_P=${P/-/_}
DESCRIPTION="A Qt4-based editor for the TikZ language"
HOMEPAGE="http://www.hackenberger.at/blog/ktikz-editor-for-the-tikz-language"
SRC_URI="http://www.hackenberger.at/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-assistant:4
	app-text/poppler[qt4]
	virtual/latex-base
	dev-texlive/texlive-latexextra
	dev-tex/pgf"
RDEPEND="${DEPEND}"

DOCS="Changelog TODO"

S="${WORKDIR}"/"${PN}"

src_prepare() {
	ls -l
	# don't install desktop icon (and cause sandbox violation)
	#sed -i -e '72,79d' src/src.pro || die "sed failed"
	# ... and libs are not equal ldflags, make that sure:
	sed -i -e 's|QMAKE_LFLAGS|LIBS|' macros.pri || die "sed failed"
	# use the correct lrelease command
	sed -i -e 's|lrelease-qt4|lrelease|' conf.pri || die "sed failed"
}

src_configure() {
	KDECONFIG="CONFIG-=usekde"
	eqmake4 qtikz.pro PREFIX="${D}/usr" "CONFIG+=nostrip" "$KDECONFIG"
}

src_install() {
	qt4-r2_src_install
}
