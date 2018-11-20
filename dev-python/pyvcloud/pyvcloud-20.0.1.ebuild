# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Python SDK for VMware vCloud Director"
HOMEPAGE="https://github.com/vmware/pyvcloud"
SRC_URI="https://files.pythonhosted.org/packages/4c/90/9d9e4d825c6779bf99d11b7dee5313f5c06442a0e77132acc4157f2af617/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
dev-python/pbr[${PYTHON_USEDEP}]
dev-python/humanfriendly[${PYTHON_USEDEP}]
dev-python/flufl-enum[${PYTHON_USEDEP}]
dev-python/lxml[${PYTHON_USEDEP}]
dev-python/pygments[${PYTHON_USEDEP}]
dev-python/pyyaml[${PYTHON_USEDEP}]
dev-python/requests[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -e '/^data_files/,+2d' -i setup.cfg || die

	distutils-r1_python_prepare_all
}
