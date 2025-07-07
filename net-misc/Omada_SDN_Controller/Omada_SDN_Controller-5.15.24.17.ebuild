# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Omada Software Controller"
HOMEPAGE="https://support.omadanetworks.com/pl/product/omada-software-controller/"
SRC_URI="https://static.tp-link.com/upload/software/2025/202506/20250618/${PN}_v${PV}_linux_x64_20250613204459.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""

RESTRICT="test strip"

RDEPEND="
	>=virtual/jre-1.17:*
	dev-db/mongodb
	net-misc/curl
	dev-java/commons-daemon
	acct-user/omada
	acct-group/omada"

S="${WORKDIR}/${PN}_v${PV}_linux_x64"

PATCHES=(
    "${FILESDIR}"/${P}-install.patch
)

INSTALL_OMADA_DIR="/opt/OmadaController"

src_install() {
	doinitd "${FILESDIR}"/omada
	fperms 755 /etc/init.d/omada
	dodir /usr/bin
	./install.sh ${ED}
	keepdir ${INSTALL_OMADA_DIR}/work
	keepdir ${INSTALL_OMADA_DIR}/logs
	keepdir ${INSTALL_OMADA_DIR}/data/db
	fowners omada:omada ${INSTALL_OMADA_DIR}/data
	fowners omada:omada ${INSTALL_OMADA_DIR}/data/db
	fowners omada:omada ${INSTALL_OMADA_DIR}/logs
	fowners omada:omada ${INSTALL_OMADA_DIR}/work
	fowners omada:omada ${INSTALL_OMADA_DIR}/properties/omada.properties
}
