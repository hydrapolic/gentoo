# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit java-pkg-2 rpm

DESCRIPTION="Extensible continuous integration server"
HOMEPAGE="http://jenkins-ci.org/"
SRC_URI="http://pkg.jenkins-ci.org/redhat-stable/RPMS/noarch/jenkins-${PV}-1.1.noarch.rpm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="+standalone"

RESTRICT="mirror"

DEPEND="media-fonts/dejavu"
RDEPEND="${DEPEND}
	>=virtual/jdk-1.5"

S="${WORKDIR}"

pkg_setup() {
	enewgroup jenkins
	enewuser jenkins -1 /bin/bash /var/lib/jenkins jenkins
}

src_install() {
	keepdir /var/log/jenkins
	keepdir /var/lib/jenkins /var/lib/jenkins/home /var/lib/jenkins/backup

	insinto /usr/share/jenkins
	doins usr/lib/jenkins/jenkins.war

	if use standalone ; then
		newinitd "${FILESDIR}/jenkins.initd" jenkins
		newconfd "${FILESDIR}/jenkins.confd" jenkins
	fi

	fowners jenkins:jenkins /var/log/jenkins
	fowners jenkins:jenkins /var/lib/jenkins /var/lib/jenkins/home /var/lib/jenkins/backup
}
