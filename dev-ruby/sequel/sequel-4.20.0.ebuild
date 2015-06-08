# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sinatra/sinatra-1.4.5.ebuild,v 1.4 2014/08/15 14:01:51 blueness Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

# no documentation is generable, it needs hanna, which is broken
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC=""

inherit ruby-fakegem

DESCRIPTION="Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort"
HOMEPAGE="http://www.sinatrarb.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
