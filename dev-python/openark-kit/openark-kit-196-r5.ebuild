# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1

DESCRIPTION="Common utilities for MySQL"
HOMEPAGE="https://code.openark.org/forge/openark-kit"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/openarkkit/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-python/mysqlclient[${PYTHON_USEDEP}]"

python_prepare() {
	2to3 -n -w --no-diffs scripts/* || die
}
