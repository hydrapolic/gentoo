# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=MAXMIND
DIST_NAME=GeoIP2
inherit perl-module

DESCRIPTION="API for MaxMind's GeoIP2 web services and databases"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-perl/Moo
	dev-perl/Data-Validate-IP
	dev-perl/namespace-clean
	dev-perl/namespace-autoclean
	dev-perl/Throwable
	dev-perl/List-SomeUtils
	dev-perl/URI
	dev-perl/List-AllUtils
	dev-perl/strictures"
