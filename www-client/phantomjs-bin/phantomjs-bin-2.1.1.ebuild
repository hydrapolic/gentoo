# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MY_PN=${PN/-bin}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Headless WebKit scriptable with a JavaScript API"
HOMEPAGE="http://phantomjs.org"
SRC_URI="https://bitbucket.org/ariya/${MY_PN}/downloads/${MY_P}-linux-x86_64.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( ChangeLog README.md )

RESTRICT="strip"
QA_PREBUILT="usr/bin/phantomjs"

S="${WORKDIR}/${MY_P}-linux-x86_64"

src_install() {
	dobin bin/phantomjs
	einstalldocs
}
