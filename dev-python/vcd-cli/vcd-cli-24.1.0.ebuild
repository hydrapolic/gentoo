# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9,11} )
inherit distutils-r1

DESCRIPTION="Command Line Interface for VMware vCloud Director"
HOMEPAGE="https://github.com/vmware/vcd-cli"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/click-7.0[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
	>=dev-python/keyring-10.6.0[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.4.7[${PYTHON_USEDEP}]
	>=dev-python/pyvcloud-22.0.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/tabulate-0.7.5[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e '/^data_files/,+2d' -i setup.cfg || die

	distutils-r1_python_prepare_all
}
