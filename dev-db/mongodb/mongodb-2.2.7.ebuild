# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mongodb/Attic/mongodb-2.2.7.ebuild,v 1.2 2014/07/23 15:42:49 ultrabug dead $

EAPI=4
SCONS_MIN_VERSION="1.2.0"
CHECKREQS_DISK_BUILD="2400M"
CHECKREQS_DISK_USR="512M"

inherit eutils flag-o-matic multilib pax-utils scons-utils user versionator check-reqs

MY_P=${PN}-src-r${PV/_rc/-rc}

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="http://www.mongodb.org"
SRC_URI="http://downloads.mongodb.org/src/${MY_P}.tar.gz
	mms-agent? ( http://dev.gentoo.org/~ultrabug/20130821-10gen-mms-agent.zip )"

LICENSE="AGPL-3 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mms-agent static-libs"

PDEPEND="mms-agent? ( dev-python/pymongo app-arch/unzip )"
RDEPEND="
	>=dev-libs/boost-1.50[threads(+)]
	dev-libs/libpcre[cxx]
	dev-util/google-perftools
	net-libs/libpcap
	app-arch/snappy"
DEPEND="${RDEPEND}
	sys-libs/readline
	sys-libs/ncurses"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	enewgroup mongodb
	enewuser mongodb -1 -1 /var/lib/${PN} mongodb

	scons_opts="  --cc=$(tc-getCC) --cxx=$(tc-getCXX) --sharedclient --usesm"
	scons_opts+=" --use-system-tcmalloc"
	scons_opts+=" --use-system-pcre"
	scons_opts+=" --use-system-snappy"
	scons_opts+=" --use-system-boost"
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.2-r1-fix-scons.patch"
	epatch "${FILESDIR}/${PN}-2.2-r1-fix-boost.patch"
	epatch "${FILESDIR}/${PN}-2.2-r2-boost-1.50.patch"
	epatch "${FILESDIR}/${PN}-2.2-fix-sharedclient.patch"

	# FIXME: apply only this fix [1] on x86 boxes as it breaks /usr/lib symlink
	# on amd64 machines [2].
	# [1] https://jira.mongodb.org/browse/SERVER-5575
	# [2] https://bugs.gentoo.org/show_bug.cgi?id=434664
	if use !prefix && [[ "$(get_libdir)" == "lib" ]]; then
		epatch "${FILESDIR}/${PN}-2.2-fix-x86client.patch"
	fi
}

src_compile() {
	escons ${scons_opts} all
}

src_install() {
	escons ${scons_opts} --full --nostrip install --prefix="${ED}"/usr

	use static-libs || rm "${ED}/usr/$(get_libdir)/libmongoclient.a"

	for x in /var/{lib,log}/${PN}; do
		keepdir "${x}"
		fowners mongodb:mongodb "${x}"
	done

	doman debian/mongo*.1
	dodoc README docs/building.md

	newinitd "${FILESDIR}/${PN}.initd-r1" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	newinitd "${FILESDIR}/${PN/db/s}.initd-r1" ${PN/db/s}
	newconfd "${FILESDIR}/${PN/db/s}.confd" ${PN/db/s}

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	if use mms-agent; then
		local MY_PN="mms-agent"
		local MY_D="/opt/${MY_PN}"
		insinto ${MY_D}
		doins "${WORKDIR}/${MY_PN}/"*
		fowners -R mongodb:mongodb ${MY_D}
		newinitd "${FILESDIR}/${MY_PN}.initd" ${MY_PN}
		newconfd "${FILESDIR}/${MY_PN}.confd" ${MY_PN}
	fi
}

src_test() {
	escons ${scons_opts} test
	"${S}"/test --dbpath=unittest || die
}

pkg_postinst() {
	if [[ ${REPLACING_VERSIONS} < 1.8 ]]; then
		ewarn "You just upgraded from a previous version of mongodb !"
		ewarn "Make sure you run 'mongod --upgrade' before using this version."
	fi
	elog "Journaling is now enabled by default, see /etc/conf.d/${PN}"
}
