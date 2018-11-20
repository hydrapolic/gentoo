# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Python SDK for VMware vCloud Director"
HOMEPAGE="https://github.com/vmware/pyvcloud"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/flufl-enum-4.1.1[${PYTHON_USEDEP}]
	>=dev-python/humanfriendly-4.8[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.2.1[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e '/^data_files/,+2d' -i setup.cfg || die

	distutils-r1_python_prepare_all
}
