# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OCI registry client"
HOMEPAGE="https://github.com/oras-project/oras"
SRC_URI="amd64? ( https://github.com/oras-project/oras/releases/download/v${PV}/oras_${PV}_linux_amd64.tar.gz )"
S="${WORKDIR}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/rpm"
BDEPEND=""

RESTRICT+=" strip"

src_install() {
	default
	dobin oras
}
