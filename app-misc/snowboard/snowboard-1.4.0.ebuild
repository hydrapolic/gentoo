# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="API blueprint toolkit"
HOMEPAGE="https://github.com/bukalapak/snowboard"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${PN}-v${PV}.linux-amd64.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	dobin ${PN}
}
