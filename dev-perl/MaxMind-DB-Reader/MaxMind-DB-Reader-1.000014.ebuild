# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=MAXMIND
inherit perl-module

DESCRIPTION="Read MaxMind DB files and look up IP addresses"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-perl/Data-IEEE754
	dev-perl/Data-Printer
	>=dev-perl/Data-Validate-IP-0.25
	dev-perl/List-AllUtils
	>=dev-perl/MaxMind-DB-Common-0.040001
	>=dev-perl/Moo-1.003000
	dev-perl/MooX-StrictConstructor
	dev-perl/namespace-autoclean
"
DEPEND="
	virtual/perl-ExtUtils-MakeMaker
	test? (
		>=dev-perl/Path-Class-0.27
		dev-perl/Test-Bits
		dev-perl/Test-Number-Delta
		dev-perl/Test-Requires
	)
"
