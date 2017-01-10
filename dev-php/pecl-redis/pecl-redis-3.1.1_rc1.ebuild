# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PHP_EXT_NAME="redis"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS=( arrays.markdown README.markdown )

USE_PHP="php5-6 php7-0 php7-1"

inherit php-ext-source-r3

MY_PV="${PV/_rc/RC}"
MY_P="${PN}_${MY_PV}"

SRC_URI="https://github.com/phpredis/phpredis/archive/${MY_PV}.tar.gz -> redis-${MY_PV}.tar.gz"

DESCRIPTION="PHP extension for interfacing with Redis"
HOMEPAGE="https://pecl.php.net/package/redis"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64"
IUSE="igbinary"

DEPEND="igbinary? (
	php_targets_php5-6? ( dev-php/igbinary[php_targets_php5-6] )
	php_targets_php7-0? ( dev-php/igbinary[php_targets_php7-0] )
	php_targets_php7-1? ( dev-php/igbinary[php_targets_php7-1] ) )"
RDEPEND="${DEPEND} !dev-php/pecl-redis:7"

# The test suite requires network access.
RESTRICT=test

src_unpack() {
	S="${WORKDIR}/phpredis-${MY_PV}"
	PHP_EXT_S="${S}"

	php-ext-source-r3_src_unpack
}

src_prepare() {
	php-ext-source-r3_src_prepare
	default_src_prepare
}

src_configure() {
	local PHP_EXT_ECONF_ARGS=(
		--enable-redis
		$(use_enable igbinary redis-igbinary)
	)
	php-ext-source-r3_src_configure
}

src_test(){
	local slot
	for slot in $(php_get_slots); do
		php_init_slot_env "${slot}"
		# Run tests for Redis class
		${PHPCLI} -d extension=modules/redis.so \
				  tests/TestRedis.php \
				  --class Redis \
				  --host ${PECL_REDIS_HOST} || die 'test suite failed'
	done
}
