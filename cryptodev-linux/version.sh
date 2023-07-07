#!/bin/bash

export git_repo="https://github.com/cryptodev-linux/cryptodev-linux.git"
export package_name="cryptodev-linux"
export package_version="1.13"
export package_full="${package_name}-${package_version}"
export custom_build=false
export require_root=false
export last_tested_commit="bb8bc7cf60d2c0b097c8b3b0e807f805b577a53f"

function run_prep() {
    cp -rv "${projdir}/suite/bookworm/debian/patches" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/rules" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/copyright" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/dkms" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/cryptodev-linux-dkms.dkms" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/cryptodev-linux-dkms.lintian-overrides" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/cryptodev-linux-dkms.postinst" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/cryptodev-linux-dkms.prerm" "${builddir}/${package_full}/debian/"
    cp -rv "${projdir}/suite/bookworm/debian/source" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/changelog" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/control" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/watch" "${builddir}/${package_full}/debian/"
    
    if ! command -v dkms &>/dev/null ; then
        echo "dkms not found: ensure that it is installed"
        exit 1
    fi
}
