# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Capturing and replaying live HTTP traffic into a test environment"
HOMEPAGE="https://goreplay.org/"
SRC_URI="amd64? ( https://github.com/buger/goreplay/releases/download/v${PV}/gor_${PV}_x64.tar.gz )"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}"

src_install() {
	dobin gor
}
