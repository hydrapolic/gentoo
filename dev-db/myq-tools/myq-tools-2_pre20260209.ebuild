# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

GH_COMMIT="363af2d5c00ca0ffceb9ae58c1f9f13f8e2e7f7b"

DESCRIPTION="Tools for monitoring MySQL"
HOMEPAGE="https://github.com/jayjanssen/myq-tools"
SRC_URI="https://github.com/jayjanssen/myq-tools/archive/${GH_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/hydrapolic/gentoo-dist/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="test"

S="${WORKDIR}/${PN}-${GH_COMMIT}/myq-status"

src_compile() {
	ego build
}

src_install() {
	default
	dobin myq-status
}
