# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN="percona-${PN/-bin}"
MY_P="${MY_PN}-${PV}"

inherit eutils

DESCRIPTION="MySQL hot backup software that performs non-blocking backups for
InnoDB and XtraDB databases"
HOMEPAGE="http://www.percona.com/software/percona-xtrabackup"
SRC_URI="
	amd64? (
		http://www.percona.com/downloads/XtraBackup/Percona-XtraBackup-${PV}/binary/tarball/${MY_P}-Linux-x86_64.tar.gz
	)
	x86? (
		http://www.percona.com/downloads/XtraBackup/Percona-XtraBackup-${PV}/binary/tarball/${MY_P}-Linux-i686.tar.gz
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/libaio
	|| ( dev-libs/libgcrypt:0/11 dev-libs/libgcrypt:11/11 )
	dev-libs/libgpg-error
	sys-libs/zlib"

src_unpack() {
	if use amd64; then
		S="${WORKDIR}/${MY_P}-Linux-x86_64"
	elif use x86; then
		S="${WORKDIR}/${MY_P}-Linux-i686"
	fi

	default
}

src_install() {
	for tool in xbcloud xbcloud_osenv xbcrypt xbstream xtrabackup; do
		dobin bin/${tool}
	done

	for man in xbcrypt xbstream xtrabackup; do
		doman man/man1/${man}.1
	done

	dosym xtrabackup /usr/bin/innobackupex
}

pkg_postinst() {
	einfo "xtrabackup 2.3.x is for MySQL/Percona Server 5.6+ and MariaDB 10.0+"
	einfo
	ewarn "innobackupex got deprecated in 2.3.x series and is just a symlink to xtrabackup"
}
