# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit user versionator

MY_PV="4.0.0-19"
MY_P=${PN}-${MY_PV}

DESCRIPTION="Tungsten Replicator is a high performance, open source, data replication engine for MySQL"
HOMEPAGE="http://code.google.com/p/tungsten-replicator/"
SRC_URI="https://s3.amazonaws.com/files.continuent.com/builds/nightly/tungsten-4.0-snapshots/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="installer"

DEPEND=">=virtual/jre-1.6
 >=dev-lang/ruby-1.8.5[ssl]
 app-arch/tar
 net-misc/rsync
 virtual/mysql"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup tungsten
	enewuser tungsten -1 /bin/bash /var/lib/tungsten mysql
}

src_install() {
	keepdir /opt/tungsten /var/lib/tungsten
	
	if use installer; then
	  dodir /opt/tungsten/.installer/${PV}
	  mv .manifest* "${D}/opt/tungsten/.installer/${PV}"
	  mv * "${D}/opt/tungsten/.installer/${PV}"
	fi

	fowners -R tungsten:mysql "/opt/tungsten" "/var/lib/tungsten"
	fperms 0750 "/opt/tungsten" "/var/lib/tungsten"

	newinitd "${FILESDIR}/tungsten.initd" tungsten
	newconfd "${FILESDIR}/tungsten.confd" tungsten
}