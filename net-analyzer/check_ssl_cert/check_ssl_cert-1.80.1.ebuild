# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Nagios plugin to check the CA and validity of an X.509 certificate"
HOMEPAGE="https://matteocorti.github.io/check_ssl_cert/"
SRC_URI="https://github.com/matteocorti/check_ssl_cert/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="app-shells/bash"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	insinto /usr/$(get_libdir)/nagios/plugins
	doins check_ssl_cert
}
