# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Enclosure LED Utilities"
HOMEPAGE="https://github.com/intel/ledmon"
SRC_URI="https://github.com/intel/ledmon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="sys-apps/sg3_utils"
