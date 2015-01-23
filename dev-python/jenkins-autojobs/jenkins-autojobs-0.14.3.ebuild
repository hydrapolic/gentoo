# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Scripts for automatically creating Jenkins jobs from scm branches"
HOMEPAGE="https://github.com/gvalkov/jenkins-autojobs"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND=">dev-python/jenkins-webapi-0.3.2
	>=dev-python/lxml-3.2.3
	>=dev-python/pyyaml-3.11
	>=dev-python/requests-2.5.0
	test? ( dev-python/pytest )"

python_test() {
	esetup.py test
}
