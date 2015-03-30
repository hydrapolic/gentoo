# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elasticsearch-curator/elasticsearch-curator-3.0.0.ebuild,v 1.1 2015/03/18 00:45:56 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Mongo connector to solr, elasticsearch or mongo"
HOMEPAGE="https://github.com/10gen-labs/mongo-connector"
SRC_URI="https://github.com/10gen-labs/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pysolr-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/elasticsearch-py-1.2[${PYTHON_USEDEP}]
	>=dev-python/pymongo-2.7.2[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
