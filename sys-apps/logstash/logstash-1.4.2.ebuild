# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Tool for managing events and logs"
HOMEPAGE="http://www.logstash.net"
SRC_URI="https://download.elasticsearch.org/${PN}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="virtual/jre:*"

src_install() {
	keepdir /etc/"${PN}"/{conf.d,patterns,plugins}
	keepdir "/var/log/${PN}"

	insinto "/etc/${PN}/conf.d"
	doins "${FILESDIR}/agent.conf.sample"

	insinto "/opt/${PN}"
	doins -r .

	insinto /etc/logrotate.d
	doins "${FILESDIR}/${PN}.logrotate"

	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
}

pkg_postinst() {
	einfo "Getting started with logstash:"
	einfo "  http://www.logstash.net/docs/${PV}/tutorials/getting-started-with-logstash"
	einfo ""
	einfo "Packages that might be interesting:"
	einfo "  app-misc/elasticsearch"
	einfo "  dev-python/elasticsearch-curator"
	einfo "  www-apps/kibana-bin"
}
