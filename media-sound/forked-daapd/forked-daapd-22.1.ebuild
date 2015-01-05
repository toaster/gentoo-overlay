# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools flag-o-matic user

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://github.com/ejurgensen/${PN}/archive/${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="itunes flac musepack lastfm"

DEPEND="
	dev-db/sqlite:3
	dev-java/antlr:3
	dev-libs/antlr-c
	dev-libs/avl
	dev-libs/confuse
	dev-libs/libevent
	dev-libs/libgcrypt
	dev-libs/libunistring
	dev-libs/mini-xml
	dev-util/gperf
	|| ( media-video/libav media-video/ffmpeg )
	>=net-dns/avahi-0.6.24
	sys-devel/gettext
	sys-libs/zlib
	itunes? ( app-pda/libplist )
	flac? ( media-libs/flac )
	musepack? ( media-libs/taglib )
	lastfm? ( net-misc/curl )
	"

RDEPEND="${DEPEND}"

src_prepare() {
	append-ldflags "-lpthread"
	eautoreconf
}

src_configure() {
	econf $(use_enable itunes) \
		$(use_enable musepack) \
		$(use_enable lastfm)
	#$(use_enable flac) \
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	newinitd "${FILESDIR}/${PN}.init.d" "${PN}"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	keepdir /var/cache/${PN}
}

pkg_preinst() {
	enewgroup daapd
	enewuser daapd -1 -1 /dev/null daapd
	fowners -R daapd:daapd /etc/${PN}.conf
	fowners -R daapd:daapd /var/cache/${PN}
	fperms -R 0600 /etc/${PN}.conf
	fperms -R 0700 /var/cache/${PN}
}

pkg_postinst() {
	einfo
	elog "You have to finalize your /etc/${PN}.conf file."
	einfo
}
