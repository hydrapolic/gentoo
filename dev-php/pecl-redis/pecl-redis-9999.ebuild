# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PHP_EXT_NAME="redis"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-3 php5-4"

inherit php-ext-source-r2 git-2

DESCRIPTION="A PHP extension for Redis"
HOMEPAGE="https://github.com/nicolasff/phpredis"
EGIT_REPO_URI="git://github.com/nicolasff/phpredis.git"
EGIT_BRANCH="master"
SRC_URI=""

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

my_conf="--enable-redis"

src_unpack() {
    git-2_src_unpack
    local slot orig_s="$S"
    for slot in $(php_get_slots); do
        cp -r "${orig_s}" "${WORKDIR}/${slot}"
    done
}

src_prepare() {
    local slot orig_s="$S"
    for slot in $(php_get_slots); do
        php_init_slot_env ${slot}
        phpize && aclocal && libtoolize --force && autoheader && autoconf
    done
}
