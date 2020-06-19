# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )
inherit distutils-r1

DESCRIPTION="https://github.com/mtakaki/cachet-url-monitor"
HOMEPAGE="https://github.com/mtakaki/cachet-url-monitor"
SRC_URI="https://github.com/mtakaki/cachet-url-monitor/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND=">=dev-python/click-7.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.3[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_prepare_all() {
	sed -e 's/, "boto3"//g' \
		-e '/setup_requires=/d' \
		-i setup.py || die

	sed -e '/boto3/d' \
		-e '/botocore/d' \
		-i cachet_url_monitor/plugins/token_provider.py || die

	distutils-r1_python_prepare_all
}
