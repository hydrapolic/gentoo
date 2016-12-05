# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PHP_EXT_NAME="ssh2"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php7-0 php7-1"

inherit php-ext-source-r2 git-r3 autotools

DESCRIPTION="PHP bindings for the libssh2 library"
EGIT_REPO_URI="https://github.com/php/pecl-networking-ssh2.git"
EGIT_BRANCH="master"
LICENSE="PHP-3.01"
SLOT="7"
DEPEND=">=net-libs/libssh2-1.7"
RDEPEND="${DEPEND}"
