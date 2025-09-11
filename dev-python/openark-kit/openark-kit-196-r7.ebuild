# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Common utilities for MySQL"
HOMEPAGE="https://code.openark.org/forge/openark-kit"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/openarkkit/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-python/mysqlclient"

PATCHES=(
	"${FILESDIR}/openark-kit-196-python3.patch"
)

src_install() {
	dobin scripts/*

	default
}
