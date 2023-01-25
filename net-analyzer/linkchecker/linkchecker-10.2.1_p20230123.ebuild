# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
PYTHON_REQ_USE="sqlite?"
DISTUTILS_USE_PEP517=hatchling
DISTUTILS_SINGLE_IMPL=1

inherit bash-completion-r1 distutils-r1 multiprocessing optfeature

DESCRIPTION="Check websites for broken links"
HOMEPAGE="https://github.com/linkcheck/linkchecker"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/linkcheck/linkchecker.git"
	inherit git-r3
else
	COMMIT="3041c8af2836bb3b3388ab8ad28f0d32bfbbbc26"
	SRC_URI="https://github.com/linkchecker/linkchecker/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="bash-completion nls pdf sqlite"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/dnspython[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	')
	bash-completion? (
		$(python_gen_cond_dep 'dev-python/argcomplete[${PYTHON_USEDEP}]') )
	pdf? (
		$(python_gen_cond_dep 'app-text/pdfminer[${PYTHON_USEDEP}]') )
"
BDEPEND="
	$(python_gen_cond_dep '
		dev-python/hatch-vcs[${PYTHON_USEDEP}]
	')
	nls? (
		$(python_gen_cond_dep '
			dev-python/polib[${PYTHON_USEDEP}]
		')
	)
	test? (
		$(python_gen_cond_dep '
			app-text/pdfminer[${PYTHON_USEDEP}]
			dev-python/parameterized[${PYTHON_USEDEP}]
			dev-python/pyftpdlib[${PYTHON_USEDEP}]
			dev-python/pyopenssl[${PYTHON_USEDEP}]
			dev-python/pytest-xdist[${PYTHON_USEDEP}]
		')
	)
"

distutils_enable_tests pytest

PATCHES=( "${FILESDIR}/${PN}-9.3-bash-completion.patch" )

DOCS=(
	doc/changelog.txt
	doc/upgrading.txt
)

python_test() {
	# Telnet test uses miniboa which is not available in Gentoo
	rm -f tests/checker/test_telnet.py
	# Multiple warnings about unclosed test sockets with epytest
	pytest -vra -n "$(makeopts_jobs)"
}

python_install_all() {
	distutils-r1_python_install_all
	if use bash-completion; then
		newbashcomp config/linkchecker-completion ${PN}
		einfo "To enable bash completion add to ~/.bashrc:"
		einfo 'eval "$(register-python-argcomplete linkchecker)"'
	fi
}

pkg_postinst() {
	optfeature "Virus scanning" app-antivirus/clamav
}
