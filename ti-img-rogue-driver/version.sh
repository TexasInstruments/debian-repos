#!/bin/bash

export git_repo="https://git.ti.com/git/graphics/ti-img-rogue-driver.git"
export package_name="ti-img-rogue-driver"
export package_version="6.1"
export package_full="${package_name}-${package_version}"
export custom_build=false
export require_root=false
export last_tested_commit="ebddb087ef140ca83e4c30d66580b0bb33b003fd"

function run_prep() {
    cp -rv "${projdir}/suite/bookworm/debian/patches" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/rules" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/copyright" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/dkms" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/ti-img-rogue-driver-dkms.dkms" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/ti-img-rogue-driver-dkms.lintian-overrides" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/ti-img-rogue-driver-dkms.postinst" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/ti-img-rogue-driver-dkms.prerm" "${builddir}/${package_full}/debian/"
    cp -rv "${projdir}/suite/bookworm/debian/source" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/changelog" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/control" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/watch" "${builddir}/${package_full}/debian/"
    rm "${builddir}/${package_full}/debian/README.Debian"
    
    if ! command -v dkms &>/dev/null then
        echo "dkms not found: ensure that it is installed"
        exit 1
    fi
}
