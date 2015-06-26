# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

DESCRIPTION="Database monitoring plugins for Nagios/Zabbix/Cacti"
HOMEPAGE="http://www.percona.com/software/percona-monitoring-plugins"
SRC_URI="http://www.percona.com/downloads/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nagios"

DEPEND=""
RDEPEND="${DEPEND}
	nagios? ( || ( net-analyzer/monitoring-plugins net-analyzer/nagios-plugins ) )"

src_install() {
	if use nagios; then
	  exeinto /usr/$(get_libdir)/nagios/plugins
	  doexe nagios/bin/*
	fi
}
