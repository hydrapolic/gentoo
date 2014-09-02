# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBI/DBI-1.628.0.ebuild,v 1.2 2014/01/20 23:09:50 vapier Exp $

EAPI=5

MODULE_AUTHOR=DAMS
MODULE_VERSION=1.975
inherit perl-module eutils

DESCRIPTION="Perl binding for Redis database"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND} dev-perl/IO-Socket-Timeout
                   virtual/perl-Module-Build
                   dev-perl/Module-Build-Tiny
				   dev-perl/Try-Tiny"

mytargets="install"
