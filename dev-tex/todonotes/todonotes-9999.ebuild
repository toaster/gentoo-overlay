inherit latex-package

DESCRIPTION="todonotes -- marking things to do in a LaTeX document"
HOMEPAGE="http://tug.ctan.org/pkg/todonotes"
SRC_URI="http://mirror.ctan.org/macros/latex/contrib/${PN}.zip"

LICENSE="LPPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	>=app-text/texlive-2008
	>=dev-texlive/texlive-latexrecommended-2008
	dev-tex/pgf"
DEPEND="${RDEPEND}
	app-arch/unzip"

TEXMF="/usr/share/texmf-site"
S="${WORKDIR}/${PN}"
