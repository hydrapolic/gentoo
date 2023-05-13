# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PHP_EXT_NAME="xmlrpc"

USE_PHP="php8-0 php8-1 php8-2"
MY_P="${PN/pecl-/}-${PV/_rc/RC}"
PHP_EXT_PECL_FILENAME="${MY_P}.tgz"
PHP_EXT_S="${WORKDIR}/${MY_P}"

inherit php-ext-pecl-r3

DESCRIPTION="Functions to write XML-RPC servers and clients"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_P}"
