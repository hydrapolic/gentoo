# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib

DESCRIPTION="GeoIP module for varnish"
HOMEPAGE="https://www.varnish-cache.org/trac/wiki/GeoipUsingInlineC"
SRC_URI="https://www.varnish-cache.org/trac/raw-attachment/wiki/GeoipUsingInlineC/GeoIP-plugin-2.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64"

DEPEND="
	dev-libs/geoip
	www-servers/varnish
	"

RDEPEND="${DEPEND}"

S="${WORKDIR}/GeoIP-plugin"

src_compile() {
	cd lib
	emake
}

src_install() {
	insinto /usr/lib64/varnish
	insopts -m755
	doins lib/geoip_plugin.so

    insinto /usr/share/varnish-geoip
	doins plugin.vcl
}

pkg_postinst() {
	elog "Check plugin.vcl and replace:"
	elog "const char* plugin_name = \"<insert full path to plugin directory>/geoip_plugin.so\";"
	elog "const char* plugin_name = \"/usr/lib64/varnish/geoip_plugin.so\";"

}
