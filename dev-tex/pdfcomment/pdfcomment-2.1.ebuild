inherit latex-package

DESCRIPTION="pdfcomment -- PDF annotations from LaTeX"
HOMEPAGE="http://pdfcomment.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${PN}_v${PV}.zip"

LICENSE="LPPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	>=app-text/texlive-2008
	>=dev-texlive/texlive-latexrecommended-2008
	>=dev-texlive/texlive-latexextra-2008"
DEPEND="${RDEPEND}
	app-arch/unzip"

TEXMF="/usr/share/texmf-site"
S=${WORKDIR}

src_install() {
	latex-package_src_install
	cd doc
	latex-package_src_install
}
