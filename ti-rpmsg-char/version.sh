#!/bin/bash

export git_repo="https://git.ti.com/git/rpmsg/ti-rpmsg-char.git"
export package_name="ti-rpmsg-char"
export package_version="0.3.0"
export package_full="${package_name}-${package_version}"
export custom_build=false
export require_root=false
export last_tested_commit="510e90d0a75bc21d79020669d2ea03f8222f3b8d"

function run_prep() {
    cp -rv "${projdir}/suite/bookworm/debian/patches" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/rules" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/copyright" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/libti-rpmsg-char-dev.install" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/libti-rpmsg-char.install" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/libti-rpmsg-char-dev.lintian-overrides" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/libti-rpmsg-char.lintian-overrides" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/watch" "${builddir}/${package_full}/debian/"
    cp -rv "${projdir}/suite/bookworm/debian/source" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/changelog" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/control" "${builddir}/${package_full}/debian/"
}
