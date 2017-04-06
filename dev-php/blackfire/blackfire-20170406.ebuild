# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

BLACKFIRE_AGENT_VERSION="1.11.0"
BLACKFIRE_PHP_VERSION="1.16.0"

BLACKFIRE_AGENT="blackfire-agent-linux_amd64"
BLACKFIRE_CLI="blackfire-cli-linux_amd64"
BLACKFIRE_PHP="blackfire-php-linux_amd64-php-70.so"

inherit user

DESCRIPTION="Blackfire.io"
HOMEPAGE="https://blackfire.io"
SRC_URI="https://packages.blackfire.io/binaries/blackfire-agent/${BLACKFIRE_AGENT_VERSION}/${BLACKFIRE_AGENT}
         https://packages.blackfire.io/binaries/blackfire-agent/${BLACKFIRE_AGENT_VERSION}/${BLACKFIRE_CLI}
	https://packages.blackfire.io/binaries/blackfire-php/${BLACKFIRE_PHP_VERSION}/${BLACKFIRE_PHP}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"
QA_PREBUILT="*"

S="${DISTDIR}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /opt/${PN} ${PN}
}

src_unpack() {
	einfo "Nothing to unpack"
}

src_install() {
	keepdir /etc/${PN}

	keepdir /opt/${PN}
	exeinto /opt/${PN}
	newexe ${BLACKFIRE_AGENT} blackfire-agent
	newexe ${BLACKFIRE_CLI} blackfire-cli

	exeinto $(php-config --extension-dir)
	newexe ${BLACKFIRE_PHP} blackfire.so

	cat > ${T}/blackfire.ini <<-EOF
	[blackfire]
	extension=blackfire.so
	blackfire.agent_timeout = 0.25
	EOF

	insinto /etc/php/apache2-php7.0/ext
	doins ${T}/blackfire.ini

	newinitd "${FILESDIR}/blackfire-agent.initd" blackfire-agent
}

pkg_postinst() {
	einfo "Run as $PN user:"
	einfo "/opt/blackfire/blackfire-agent --register"
	einfo "and then /etc/init.d/blackfire-agent start"
}
