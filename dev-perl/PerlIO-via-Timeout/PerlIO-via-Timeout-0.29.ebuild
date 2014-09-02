# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR=DAMS
MODULE_VERSION=0.29
inherit perl-module

DESCRIPTION="PerlIO layer that adds read & write timeout to a handle"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/perl-Module-Build 
		dev-perl/Module-Build-Tiny"

mytargets="install"
