# Copyright 2022-2025 Qualys

EAPI=8

DESCRIPTION="Qualys Cloud Agent"
HOMEPAGE="https://qualys.com/"
SRC_URI="http://localhost/${P}.gpkg.tar"
S="${WORKDIR}"
SLOT="0"
KEYWORDS="amd64"

src_unpack() {
	default
	unpack "${S}/image.tar.gz"
}

src_install() {
	keepdir /etc/qualys/cloud-agent
	insinto /etc/qualys
	doins -r "${S}"/etc/qualys/*

	keepdir /usr/local/qualys/cloud-agent/{lib,bin,sock,manifests,correlation,correlation/manifests}
	insinto /usr/local/qualys/cloud-agent
	doins -r "${S}"/usr/local/qualys/cloud-agent/*

	dodoc -r "${S}"/usr/share/doc/${P}/*

	newinitd "${FILESDIR}/qualys-cloud-agent.initd" qualys-cloud-agent

	keepdir /var/log/qualys
	fperms 0770 /etc/qualys/cloud-agent /var/log/qualys
	fperms 0755 /usr/local/qualys/cloud-agent

	# Setting executable permissions to scripts and binaries
	fperms -R 700 /usr/local/qualys/cloud-agent/bin
	fperms 755 /etc/qualys/cloud-agent/.gentoo/qualys-cloud-agent
}
