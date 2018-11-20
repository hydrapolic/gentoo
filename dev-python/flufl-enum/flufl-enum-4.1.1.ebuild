# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="A Python enumeration package"
HOMEPAGE="https://launchpad.net/flufl.enum"
SRC_URI="https://files.pythonhosted.org/packages/65/51/aa79e41a6deefab555a7cc26a917363c67c6b7e2e1b43067f3d11b5e1b7e/flufl.enum-${PV}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/flufl.enum-${PV}"
