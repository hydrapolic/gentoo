# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PHP_EXT_NAME="redis"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php7-0"

DOCS="README ChangeLog"

inherit php-ext-source-r2 git-r3 autotools

KEYWORDS="amd64"

DESCRIPTION="This extension provides an API for communicating with Redis servers"
EGIT_REPO_URI="https://github.com/phpredis/phpredis.git"
EGIT_BRANCH="php7"
LICENSE="PHP-3.01"
SLOT="0"

src_configure() {
	my_conf="--enable-redis"
	php-ext-source-r2_src_configure
}
