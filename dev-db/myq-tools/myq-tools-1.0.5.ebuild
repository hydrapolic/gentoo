# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Tools for monitoring MySQL"
HOMEPAGE="https://github.com/jayjanssen/myq-tools"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="dev-lang/go:=
	dev-go/gox"

S="${WORKDIR}/src/github.com/jayjanssen/myq-tools"

src_unpack() {
	mkdir -p "${S%/*}" || die
	unpack ${P}.tar.gz
	mv "${P}" "${S}" || die
}

src_compile() {
	cd ${S} || die
	GO111MODULE="off" GOPATH="${WORKDIR}" gox -os=linux -arch=amd64 -output=myq_status
}

src_install() {
	default
	dobin myq_status
}
