# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/go-sql-driver/mysql v1.6.0"
	"github.com/go-sql-driver/mysql v1.6.0/go.mod"
	"github.com/go-sql-driver/mysql v1.7.0"
	"github.com/go-sql-driver/mysql v1.7.0/go.mod"
	"github.com/hashicorp/errwrap v1.0.0"
	"github.com/hashicorp/errwrap v1.0.0/go.mod"
	"github.com/hashicorp/errwrap v1.1.0"
	"github.com/hashicorp/errwrap v1.1.0/go.mod"
	"github.com/hashicorp/go-multierror v1.1.1"
	"github.com/hashicorp/go-multierror v1.1.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/objx v0.5.0"
	"github.com/stretchr/objx v0.5.0/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/stretchr/testify v1.8.2"
	"github.com/stretchr/testify v1.8.2/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/ini.v1 v1.66.6"
	"gopkg.in/ini.v1 v1.66.6/go.mod"
	"gopkg.in/ini.v1 v1.67.0"
	"gopkg.in/ini.v1 v1.67.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals

GH_COMMIT="7af2abe7d5032489408451e9f0fae7a5f95930cc"

DESCRIPTION="Tools for monitoring MySQL"
HOMEPAGE="https://github.com/jayjanssen/myq-tools"
SRC_URI="https://github.com/jayjanssen/myq-tools/archive/${GH_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="test"

S="${WORKDIR}/${PN}-${GH_COMMIT}/cli/myq-status"

src_compile() {
	ego build
}

src_install() {
	default
	dobin myq-status
}
