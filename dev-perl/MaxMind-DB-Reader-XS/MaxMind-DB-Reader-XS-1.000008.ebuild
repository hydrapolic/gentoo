# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=MAXMIND
DIST_NAME=MaxMind-DB-Reader-XS
inherit perl-module

DESCRIPTION="Read MaxMind DB files and look up IP addresses"

SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-perl/Module-Build"
RDEPEND=""
