# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PHP_EXT_NAME="smbclient"
USE_PHP="php7-2 php7-1 php7-0"

inherit php-ext-source-r2 eutils

DESCRIPTION="PHP wrapper for libsmbclient"
HOMEPAGE="https://github.com/eduardok/libsmbclient-php"
SRC_URI="https://github.com/eduardok/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="net-fs/samba[client]"
