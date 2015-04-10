# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN="logstash"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Tool for managing events and logs"
HOMEPAGE="http://www.logstash.net"
SRC_URI="https://download.elasticsearch.org/${MY_PN}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="virtual/jre:*"

src_install() {
	keepdir /etc/"${MY_PN}"/{conf.d,patterns,plugins}
	keepdir "/var/log/${MY_PN}"

	insinto "/etc/${MY_PN}/conf.d"
	doins "${FILESDIR}/agent.conf.sample"

	insinto "/opt/${MY_PN}"
	doins -r .

	insinto /etc/logrotate.d
	doins "${FILESDIR}/${MY_PN}.logrotate"

	newconfd "${FILESDIR}/${MY_PN}.confd" "${MY_PN}"
	newinitd "${FILESDIR}/${MY_PN}.initd" "${MY_PN}"
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
