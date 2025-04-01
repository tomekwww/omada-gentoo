# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Omada Software Controller"
HOMEPAGE="https://support.omadanetworks.com/pl/product/omada-software-controller/"
SRC_URI="https://static.tp-link.com/upload/software/2025/202503/20250321/${PN}_v${PV}_linux_x64.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""

RESTRICT="test"

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

INSTALL_OMADA_DIR="${ED}/opt/OmadaController"

src_install() {
	./install.sh ${ED}
	keepdir ${INSTALL_OMADA_DIR}/work
	fowners omada:omada ${INSTALL_OMADA_DIR}/data
	fowners omada:omada ${INSTALL_OMADA_DIR}/logs
	fowners omada:omada ${INSTALL_OMADA_DIR}/work
}
