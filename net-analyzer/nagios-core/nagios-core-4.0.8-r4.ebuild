# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit depend.apache eutils multilib toolchain-funcs user

MY_P=${PN/-core}-${PV}
DESCRIPTION="Nagios Core - Check daemon, CGIs, docs"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="classicui lighttpd perl +web vim-syntax"

# sys-devel/libtool dependency is bug #401237.
DEPEND="sys-devel/libtool
	virtual/mailx
	perl? ( dev-lang/perl )
	web? (
		media-libs/gd[jpeg,png]
		lighttpd? ( www-servers/lighttpd dev-lang/php[cgi] )
		apache2? ( || ( dev-lang/php[apache2] dev-lang/php[cgi] ) )
	)"
RDEPEND="${DEPEND}
	!net-analyzer/nagios-imagepack
	vim-syntax? ( app-vim/nagios-syntax )"

want_apache2

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	depend.apache_pkg_setup

	enewgroup nagios
	enewuser nagios -1 /bin/bash /var/nagios/home nagios
}

src_prepare(){
	# Upstream bug, fixes a QA warning:
	#
	#  http://tracker.nagios.org/view.php?id=650
	#
	epatch "${FILESDIR}"/use-MAKE-instead-of-bare-make.patch
}

src_configure() {
	local myconf

	if use perl; then
		myconf="${myconf} --enable-embedded-perl --with-perlcache"
	fi

	if use !apache2 && use !lighttpd ; then
		myconf="${myconf} --with-command-group=nagios"
	else
		if use apache2 ; then
			myconf="${myconf} --with-command-group=apache"
			myconf="${myconf} --with-httpd-conf=/etc/apache2/conf.d"
		elif use lighttpd ; then
			myconf="${myconf} --with-command-group=lighttpd"
		fi
	fi

	econf ${myconf} \
		--prefix=/usr \
		--bindir=/usr/sbin \
		--sbindir=/usr/$(get_libdir)/nagios/cgi-bin \
		--datadir=/usr/share/nagios/htdocs \
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--libexecdir=/usr/$(get_libdir)/nagios/plugins
}

src_compile() {
	emake CC=$(tc-getCC) nagios

	if use web; then
		# Only compile the CGIs when USE=web is set.
		emake CC=$(tc-getCC) DESTDIR="${D}" cgis
	fi
}

src_install() {
	dodoc Changelog INSTALLING LEGAL README.asciidoc UPGRADING

	emake DESTDIR="${D}" install-base
	emake DESTDIR="${D}" install-basic
	emake DESTDIR="${D}" install-config
	emake DESTDIR="${D}" install-commandmode

	if use web; then
		emake DESTDIR="${D}" install-cgis

		# install-html installs the new exfoliation theme
		emake DESTDIR="${D}" install-html

		if use classicui; then
			# This overwrites the already-installed exfoliation theme
			emake DESTDIR="${D}" install-classicui
		fi
	fi

	newinitd "${FILESDIR}"/nagios4 nagios
	newconfd "${FILESDIR}"/conf.d nagios

	if use web ; then
		if use apache2 ; then
			# Install the Nagios configuration file for Apache.
			insinto "${APACHE_MODULES_CONFDIR}"
			doins "${FILESDIR}"/99_nagios3.conf
		elif use lighttpd ; then
			# Install the Nagios configuration file for Lighttpd.
			insinto /etc/lighttpd
			newins "${FILESDIR}/lighttpd_nagios3-r1.conf" nagios.conf
		else
			ewarn "${CATEGORY}/${PF} only supports apache or lighttpd"
			ewarn "out of the box. Since you are not using one of them, you"
			ewarn "will have to configure your webserver yourself."
		fi
	fi

	for dir in etc/nagios var/nagios ; do
		chown -R nagios:nagios "${D}/${dir}" \
			|| die "failed chown of ${D}/${dir}"
	done

	chown -R root:root "${D}/usr/$(get_libdir)/nagios"

	# The following two find...exec statements will die properly as long
	# as chmod is only called once (that is, as long as the argument
	# list is small enough).
	find "${D}/usr/$(get_libdir)/nagios" -type d \
		-exec chmod 755 '{}' + || die 'failed to make nagios dirs traversable'

	if use web; then
		find "${D}/usr/$(get_libdir)/nagios/cgi-bin" -type f \
			-exec chmod 755 '{}' + || die 'failed to make cgi-bins executable'
	fi

	keepdir /etc/nagios
	keepdir /var/nagios
	keepdir /var/nagios/archives
	keepdir /var/nagios/rw
	keepdir /var/nagios/spool/checkresults

	if use !apache2 && use !lighttpd; then
		chown -R nagios:nagios "${D}"/var/nagios/rw \
			|| die "failed chown of ${D}/var/nagios/rw"
	else
		if use apache2 ; then
			chown -R nagios:apache "${D}"/var/nagios/rw \
				|| die "failed chown of ${D}/var/nagios/rw"
		elif use lighttpd ; then
			chown -R nagios:lighttpd "${D}"/var/nagios/rw \
				|| die "failed chown of ${D}/var/nagios/rw"
		fi
	fi

	chmod ug+s "${D}"/var/nagios/rw || die "failed chmod of ${D}/var/nagios/rw"
	chmod 0750 "${D}"/etc/nagios || die "failed chmod of ${D}/etc/nagios"
}

pkg_postinst() {

	if use web; then
		elog "Note that your web server user requires read-only access to"
		elog "${ROOT}etc/nagios."

		if use apache2 || use lighttpd ; then
			elog
			elog "There are several possible solutions to accomplish this,"
			elog "choose the one you are most comfortable with:"
			elog
			if use apache2 ; then
				elog "	usermod -G nagios apache"
				elog "or"
				elog "	chown nagios:apache /etc/nagios"
				elog
				elog "Also edit /etc/conf.d/apache2 and add \"-D NAGIOS\""
			elif use lighttpd ; then
				elog "  usermod -G nagios lighttpd "
				elog "or"
				elog "  chown nagios:lighttpd /etc/nagios"
			fi
			elog
			elog "That will make nagios's web front-end available at"
			elog "  http://localhost/nagios/"
			elog
		else
			elog "IMPORTANT: Do not forget to add your web server user"
			elog "to the nagios group!"
		fi
	fi

	elog
	elog "If your kernel has /proc protection, nagios"
	elog "will not be happy as it relies on accessing the proc"
	elog "filesystem. You can fix this by adding nagios into"
	elog "the group wheel, but this is not recomended."
	elog
}

pkg_postinst() {
	einfo "Fixing permissions on ${ROOT}var/nagios"
	chown nagios:nagios "${ROOT}"var/nagios
}
