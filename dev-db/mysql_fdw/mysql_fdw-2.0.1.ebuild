# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
POSTGRES_COMPAT=( 9.{3,4} )

MY_PV=${PV//\./_}

DESCRIPTION="MySQL Foreign Data Wrapper for PostgreSQL"
HOMEPAGE="https://github.com/EnterpriseDB/mysql_fdw"
SRC_URI="https://github.com/EnterpriseDB/${PN}/archive/REL-${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/mysql
	|| (
		dev-db/postgresql:9.4[server]
		dev-db/postgresql:9.3[server]
	)"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-REL-${MY_PV}

src_compile() {
	emake USE_PGXS=1
}

src_install() {
	emake DESTDIR="${D}" USE_PGXS=1 install
}
