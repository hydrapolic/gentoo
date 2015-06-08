# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/jekyll/jekyll-2.5.3.ebuild,v 1.2 2015/01/25 09:13:52 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-fakegem

#RUBY_FAKEGEM_EXTRADOC=""
#RUBY_FAKEGEM_EXTRAINSTALL=""

DESCRIPTION="A simple, blog aware, static site generator"
HOMEPAGE="http://jekyllrb.com http://github.com/jekyll/jekyll"
SRC_URI="https://github.com/jekyll/jekyll-import/archive/v0.6.0.tar.gz  -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#ruby_add_rdepend ""
#ruby_add_bdepend ""
