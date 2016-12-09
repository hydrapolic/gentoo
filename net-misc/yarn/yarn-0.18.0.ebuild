# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI=5

DESCRIPTION="Fast, reliable, and secure dependency management. https://yarnpkg.com"
HOMEPAGE="https://yarnpkg.com/"
LICENSE="BSD"
KEYWORDS="amd64"
SRC_URI="https://github.com/yarnpkg/yarn/releases/download/v${PVR}/yarn-v${PVR}.tar.gz"
SLOT="0"

DEPEND="|| ( net-libs/nodejs net-libs/nodejs-bin )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/dist"

src_install() {
	dest="/usr/local/${PN}"

	dodir "${dest}"
	cp -r "${S}"/* "${D}/${dest}"
	dodir "/usr/local/bin"
	dosym ${dest}/bin/yarn /usr/local/bin/yarn
}