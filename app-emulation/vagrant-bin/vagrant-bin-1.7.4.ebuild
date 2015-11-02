# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit rpm

MY_PN="vagrant"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="A tool for building and distributing virtual machines"
HOMEPAGE="https://www.vagrantup.com"
SRC_URI="amd64? ( https://dl.bintray.com/mitchellh/${MY_PN}/${MY_P}_x86_64.rpm )
		x86? ( https://dl.bintray.com/mitchellh/${MY_PN}/${MY_P}_i686.rpm )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="virtualbox"

DEPEND="!app-emulation/vagrant"
RDEPEND="virtualbox? ( || ( app-emulation/virtualbox app-emulation/virtualbox-bin ) )"

S="${WORKDIR}"

src_install() {
	mv * "${D}/"
}
