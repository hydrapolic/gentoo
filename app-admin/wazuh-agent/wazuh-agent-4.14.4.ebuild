# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open Source Security Platform agent"
HOMEPAGE="https://wazuh.com/ https://github.com/wazuh/wazuh"
SRC_URI="amd64? ( https://packages.wazuh.com/4.x/yum/${P}-1.x86_64.tar )"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="strip"
QA_PREBUILT="
	var/ossec/lib/*so
	var/ossec/active-response/bin/*
"

S="${WORKDIR}"

RDEPEND="
	acct-group/wazuh
	acct-user/wazuh
"

src_prepare() {
	default

	# generated, don't override
	rm -v var/ossec/etc/client.keys
}

src_install() {
	# empty dirs
	keepdir /var/ossec
	keepdir /var/ossec/.ssh
	keepdir /var/ossec/backup
	keepdir /var/ossec/ruleset
	keepdir /var/ossec/ruleset/sca

	insinto /var
	doins -r var/ossec

	fowners -R wazuh:wazuh /var/ossec/etc
	fowners -R wazuh:wazuh /var/ossec/logs
	fowners -R wazuh:wazuh /var/ossec/queue
	fowners -R wazuh:wazuh /var/ossec/tmp
	fowners -R wazuh:wazuh /var/ossec/var

	fperms -R +x /var/ossec/bin /var/ossec/active-response/bin

	newinitd "${FILESDIR}/${PN}.initd" ${PN}

	# dirs owned by wazuh
	diropts -m0750 -o wazuh -g wazuh
	keepdir /var/ossec/logs
	keepdir /var/ossec/logs/wazuh
	keepdir /var/ossec/queue/alerts
	keepdir /var/ossec/queue/diff
	keepdir /var/ossec/queue/fim
	keepdir /var/ossec/queue/fim/db
	keepdir /var/ossec/queue/logcollector
	keepdir /var/ossec/queue/rids
	keepdir /var/ossec/queue/sockets
	keepdir /var/ossec/queue/syscollector/db
	keepdir /var/ossec/var/incoming
	keepdir /var/ossec/var/run
	keepdir /var/ossec/var/upgrade
	keepdir /var/ossec/var/wodles
}
