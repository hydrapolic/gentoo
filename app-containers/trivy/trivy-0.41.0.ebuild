# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A Simple and Comprehensive Vulnerability Scanner for Containers, Suitable for CI"
HOMEPAGE="https://github.com/aquasecurity/trivy"
SRC_URI="amd64? ( https://github.com/aquasecurity/trivy/releases/download/v${PV}/trivy_${PV}_Linux-64bit.tar.gz )"
S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/rpm
	!app-misc/trivy"
BDEPEND=""

RESTRICT+=" strip"

src_install() {
	default
	dobin trivy
}
