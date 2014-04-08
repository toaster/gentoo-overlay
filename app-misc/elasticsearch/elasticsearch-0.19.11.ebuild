# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit user

DESCRIPTION="flexible and powerful open source, distributed real-time
search and analytics engine for the cloud"
HOMEPAGE="http://www.elasticsearch.org/"
SRC_URI="https://download.elasticsearch.org/${PN}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	virtual/jre
	net-misc/curl
"

pkg_setup() {
	enewgroup elasticsearch
	enewuser elasticsearch -1 -1 -1 elasticsearch
}

src_install() {
	local dest=/opt/${PN}

	insinto ${dest}
	doins -r *.* config

	insinto ${dest}/lib
	doins -r lib/*.*

	insinto ${dest}/lib/sigar
	doins -r lib/sigar/libsigar-${ARCH}-linux.so

	exeinto ${dest}/bin
	doexe bin/*

	insinto /etc/${PN}
	doins config/logging.yml
	doins "${FILESDIR}"/elasticsearch.yml

	newconfd "${FILESDIR}"/elasticsearch-confd ${PN}
	newinitd "${FILESDIR}"/elasticsearch-initd ${PN}

	for path in /var/lib/${PN} /var/log/${PN}; do
		keepdir "${path}"
		fowners elasticsearch:elasticsearch "${path}"
	done
}
