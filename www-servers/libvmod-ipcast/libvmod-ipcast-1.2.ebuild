# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

VARNISH_VERSION="3.0.7"

DESCRIPTION="Convert strings to IP adresses for ACL checks in Varnish VCL"
HOMEPAGE="https://github.com/lkarsten/libvmod-ipcast"

SRC_URI="https://github.com/lkarsten/${PN}/archive/${P}.tar.gz
	http://repo.varnish-cache.org/source/varnish-${VARNISH_VERSION}.tar.gz"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"
IUSE="doc"

DEPEND=">=www-servers/varnish-${VARNISH_VERSION}
	<www-servers/varnish-4"

RDEPEND="${DEPEND}"

S="${WORKDIR}"
VARNISH="${WORKDIR}/varnish-${VARNISH_VERSION}"
VMOD="${WORKDIR}/${PN}-${P}"

src_prepare() {
	cd "${VARNISH}"
	econf
	emake
	
	if ! use doc; then
		cd "${VMOD}"
		epatch "${FILESDIR}/nodoc.patch"
	fi
}

src_compile() {
	cd ${VMOD}
	./autogen.sh
	econf VARNISHSRC=${VARNISH}
	emake
}

src_install() {
 	cd ${VMOD}
	emake DESTDIR="${D}" install
}
