#!/bin/bash

export git_repo="https://git.ti.com/git/k3conf/k3conf.git"
export package_name="k3conf"
export package_version="0.1-90"
export package_full="${package_name}-${package_version}"
export custom_build=false
export require_root=false

function run_prep() {
    cp -rv "${projdir}/suite/bookworm/debian/patches" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/rules" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/copyright" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/k3conf.manpages" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/k3conf.1" "${builddir}/${package_full}/debian/"
    cp -rv "${projdir}/suite/bookworm/debian/source" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/changelog" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/control" "${builddir}/${package_full}/debian/"
}

