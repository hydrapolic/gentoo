# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1

DESCRIPTION="A Python API for accessing resources on a Jenkins continuous-integration server"
HOMEPAGE="https://github.com/salimfadhley/jenkinsapi"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="dev-python/pytz
	dev-python/requests
	test? ( dev-python/mock
		dev-python/nose
		dev-python/coverage
		dev-python/unittest2
	)"

python_test() {
	esetup.py test
}
