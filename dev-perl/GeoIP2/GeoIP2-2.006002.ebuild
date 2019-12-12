# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=MAXMIND
inherit perl-module

DESCRIPTION="API for MaxMind's GeoIP2 web services and databases"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-perl/Moo
	>=dev-perl/Data-Validate-IP-0.25
	dev-perl/namespace-clean
	dev-perl/namespace-autoclean
	dev-perl/Throwable
	dev-perl/List-SomeUtils
	dev-perl/URI
	dev-perl/List-AllUtils
	dev-perl/strictures
	>=dev-perl/MaxMind-DB-Reader-1.000000
	dev-perl/MaxMind-DB-Reader-XS
	dev-perl/HTTP-Message
	dev-perl/JSON-MaybeXS
	dev-perl/libwww-perl
	dev-perl/LWP-Protocol-https
	dev-perl/Params-Validate
"
DEPEND="
	virtual/perl-ExtUtils-MakeMaker
	test? (
	dev-perl/HTTP-Message
	dev-perl/JSON-MaybeXS
	dev-perl/libwww-perl
	dev-perl/LWP-Protocol-https
	dev-perl/Params-Validate
)"
