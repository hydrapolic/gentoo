# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ansible/ansible-1.6.8.ebuild,v 1.1 2014/07/23 08:40:19 jlec Exp $

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 readme.gentoo

DESCRIPTION="Radically simple deployment, model-driven configuration management, and command execution framework"
HOMEPAGE="http://ansible.com/"
SRC_URI="https://github.com/ansible/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="test"

DEPEND="test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/passlib[${PYTHON_USEDEP}]
		dev-vcs/git
	)"
RDEPEND="
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	net-misc/sshpass
	virtual/ssh
"

python_test() {
	make tests || die "tests failed"
}

python_install_all() {
	distutils-r1_python_install_all

	doman docs/man/man1/*.1
	dodoc -r examples
	docompress -x /usr/share/doc/${PF}/examples
	# Hint: do not install example config files into /etc
	# let this choice to user

	newenvd "${FILESDIR}"/${PN}.env 95ansible
}

src_install() {
	distutils-r1_src_install
	readme.gentoo_create_doc
}
