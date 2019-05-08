# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1

DESCRIPTION="Common utilities for MySQL"
HOMEPAGE="https://code.openark.org/forge/openark-kit"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/openarkkit/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-python/mysql-python[${PYTHON_USEDEP}]"
