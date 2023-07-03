#!/bin/bash

export git_repo="https://git.ti.com/git/wilink8-wlan/18xx-ti-utils.git"
export package_name="wl18xx-ti-utils"
export package_version="0.8"
export package_full="${package_name}-${package_version}"
export custom_build=false
export require_root=false
export last_tested_commit="7325bf0b7b2d462e334437d2c7f9198d0ac55ce2"

function run_prep() {
    cp -rv "${projdir}/suite/bookworm/debian/patches" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/rules" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/copyright" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/wl18xx-ti-utils.manpages" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/wlconf.1" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/calibrator.1" "${builddir}/${package_full}/debian/"
    cp -rv "${projdir}/suite/bookworm/debian/source" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/changelog" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/control" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/wl18xx-ti-utils.lintian-overrides" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/watch" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/README.Debian" "${builddir}/${package_full}/debian/"
}

