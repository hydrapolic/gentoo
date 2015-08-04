# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit base

DESCRIPTION="A tool to load and stress a computer system"
HOMEPAGE="http://kernel.ubuntu.com/~cking/stress-ng/"
SRC_URI="http://kernel.ubuntu.com/~cking/tarballs/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/stress-ng-keyctl.patch )
