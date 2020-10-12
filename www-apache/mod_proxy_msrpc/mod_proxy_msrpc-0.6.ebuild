# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit apache-module autotools

DESCRIPTION="Outlook Anywhere support in reverse proxy setups"
HOMEPAGE="https://github.com/bombadil/mod_proxy_msrpc"
SRC_URI="https://github.com/bombadil/mod_proxy_msrpc/archive/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-libs/check"
DEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${P}"

need_apache2_4

src_prepare() {
	default
	eautoreconf
}

src_compile() {
	default
}

src_install() {
	APACHE2_MOD_CONF="20_${PN}"
	APACHE_MODULESDIR="/usr/$(get_libdir)/apache2/modules"

	apache-module_src_install
}
