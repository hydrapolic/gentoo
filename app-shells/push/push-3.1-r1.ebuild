# Copyright 2012-2018 Martin V\"ath
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A POSIX shell function to treat a variable like an array, quoting args"
HOMEPAGE="https://github.com/vaeth/push/"
SRC_URI="https://github.com/vaeth/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x64-cygwin ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

IUSE=""

# Install into / to let sys-block/zram-init work with split /usr

src_compile() {
	emake PREFIX= EPREFX="${EPREFIX}" DATADIR=/lib/push
}

src_install() {
	dodoc README.md
	emake DESTDIR="${ED}" PREFIX= EPREFX="${EPREFIX}" DATADIR=/lib/push install
}
