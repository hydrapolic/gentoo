# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="File archiver using QuickLZ"
HOMEPAGE="http://www.quicklz.com"
SRC_URI="http://www.quicklz.com/${P}-source.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_prepare() {
	sed -i '1i #include <unistd.h>' qpress.cpp

	default
}

src_install() {
	dobin qpress
}
