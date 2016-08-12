# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit rpm versionator pax-utils

MY_PV=$(replace_version_separator 2 '-')

SRC_URI_BASE="ftp://ftp.hp.com/pub/softlib2/software1/pubsw-linux"
AMD64_PID="1857046646"
AMD64_VID="114618"
X86_PID="1999196580"
X86_VID="114619"

DESCRIPTION="HPE Smart Storage Administrator (HPE SSA) CLI (formerly HPACUCLI and CPQACUXE)"
HOMEPAGE="http://h18000.www1.hp.com/products/servers/linux/documentation.html"
SRC_URI="
	amd64? ( ${SRC_URI_BASE}/p${AMD64_PID}/v${AMD64_VID}/${PN}-${MY_PV}.x86_64.rpm )
	x86? ( ${SRC_URI_BASE}/p${X86_PID}/v${X86_VID}/${PN}-${MY_PV}.i386.rpm )"

LICENSE="hp-proliant-essentials"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="app-arch/rpm2targz"
RDEPEND="sys-apps/coreutils
	sys-process/procps
	>=sys-apps/util-linux-2.20.1"

S="${WORKDIR}"

HPSSACLI_BASEDIR="/opt/hp/hpssacli"
QA_PREBUILT="${HPSSACLI_BASEDIR}/*"

src_install() {
	local MY_S="${S}/opt/hp/${PN}/bld"

	newsbin "${FILESDIR}"/"${PN}-wrapper" hpssacli
	dosym /usr/sbin/hpssacli /usr/sbin/hpssascripting
	dosym /usr/sbin/hpssacli /usr/sbin/hprmstr

	exeinto "${HPSSACLI_BASEDIR}"
	for bin in "${MY_S}"/hprmstr "${MY_S}"/hpssacli "${MY_S}"/hpssascripting; do
		local basename=$(basename "${bin}")
		newexe "${bin}" ${basename#.}.bin
	done

	dodoc "${MY_S}"/*.txt
	dodoc "${MY_S}"/*.license
	doman "${S}"/usr/man/man*/*

	cat <<-EOF >"${T}"/45${PN}
		LDPATH=${HPSACLI_BASEDIR}
		EOF
	doenvd "${T}"/45${PN}

	pax-mark m "${D}/opt/hp/hpssacli/"*
}

pkg_postinst() {
	elog
	elog "For more information regarding this utility, please read"
	elog "/usr/share/doc/${P}/${PN}-${MY_PV}.noarch.txt"
	elog
}
