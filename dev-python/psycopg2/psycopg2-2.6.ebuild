# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

MY_PV=${PV/-/_}

inherit distutils-r1

DESCRIPTION="PostgreSQL adapter for Python"
HOMEPAGE="http://initd.org/psycopg/"
SRC_URI="https://github.com/psycopg/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-db/postgresql"
RDEPEND="${DEPEND}"

python_test() {
	# tests connect to local database
	export PSYCOPG2_TESTDB="gentoo_psycopg2_test"
	export PSYCOPG2_TESTDB_HOST="localhost"
	export PSYCOPG2_TESTDB_PORT="5432"
	export PSYCOPG2_TESTDB_USER="postgres"

	dropdb ${PSYCOPG2_TESTDB} -U ${PSYCOPG2_TESTDB_USER}
	createdb ${PSYCOPG2_TESTDB} -U ${PSYCOPG2_TESTDB_USER} || die "Cannot create testing database"
	
	make check || die "Tests failed for ${EPYTHON}"
	
	dropdb ${PSYCOPG2_TESTDB} -U ${PSYCOPG2_TESTDB_USER} || die "Failed to cleanup testing database"
}
