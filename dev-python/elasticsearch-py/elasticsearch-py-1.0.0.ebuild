# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1

MY_PN="elasticsearch"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Official Python low-level client for Elasticsearch"
HOMEPAGE="https://github.com/elasticsearch/elasticsearch-py"
SRC_URI="https://pypi.python.org/packages/source/${MY_PN:1:0}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="APACHE-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"
