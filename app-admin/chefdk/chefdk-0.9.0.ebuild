# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit rpm

DESCRIPTION="A streamlined development and deployment workflow for Chef platform"
HOMEPAGE="https://github.com/chef/chef-dk"
SRC_URI="https://opscode-omnibus-packages.s3.amazonaws.com/el/7/x86_64/${P}-1.el7.x86_64.rpm"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	mv * "${D}/"  
}
