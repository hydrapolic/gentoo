# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools libtool

MY_P="fts-elastic"
MY_P="${MY_P}-${PV}"

DESCRIPTION="ElasticSearch FTS implementation for the Dovecot mail server"
HOMEPAGE="https://github.com/filiphanes/fts-elastic"
SRC_URI="https://github.com/filiphanes/fts-elastic/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-libs/json-c:*
	net-mail/dovecot"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS=( elastic6-schema.json elastic7-schema.json )

src_configure() {
	eautoreconf
	econf --with-dovecot=/usr/$(get_libdir)/dovecot
}

src_install() {
	default
	rm "${D}"/usr/lib64/dovecot/lib21_fts_elastic_plugin.la || die
}
