# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1 eutils

DESCRIPTION="Microsoft Azure Linux Guest Agent"
HOMEPAGE="https://github.com/Azure/WALinuxAgent"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-libs/openssl-1.0.0:*
	>=net-misc/openssh-5.3
	dev-python/pyasn1[${PYTHON_USEDEP}]
	sys-apps/util-linux
	sys-block/parted
	sys-apps/shadow
	app-admin/sudo
	sys-apps/iproute2
	sys-apps/sed
	sys-apps/grep
	app-portage/eix"

S="${WORKDIR}/WALinuxAgent-${PV}"

src_prepare() {
	# do not install tests
	rm -rf tests
	
	# allow root login
	# use ed25519 instead of rsa
	sed -i \
		-e '/Provisioning.DeleteRootPassword/s/=.*$/=n/' \
		-e '/Provisioning.SshHostKeyPairType/s/=.*$/=ed25519/' \
		-e '/AutoUpdate.Enabled/s/=.*$/=n/' \
		"${S}"/config/waagent.conf || die

	# install init.d / logrotate in gentoo way
	sed -i \
		-e '/set_logrotate_files(data_files)/d' \
		-e 's/set_sysv_files(data_files)/print/g' \
		-e 's@/etc/udev/rules.d/@/lib/udev/rules.d/@g' \
		"${S}"/setup.py || die

	# use dhcpcd instead of dhcp that fails to start
	# "Unable to set up timer: out of range"
	sed -i -e 's/pidof dhclient/pidof dhcpcd/' \
		"${S}"/azurelinuxagent/common/osutil/default.py || die

	default
}

python_install_all() {
	newinitd "${FILESDIR}"/waagent.initd waagent

	insinto "/etc"
	doins config/waagent.conf

	insinto /etc/logrotate.d
	newins config/waagent.logrotate waagent

	keepdir /var/lib/waagent
	
	distutils-r1_python_install_all
}
