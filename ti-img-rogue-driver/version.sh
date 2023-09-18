#!/bin/bash

export git_repo="https://git.ti.com/git/graphics/ti-img-rogue-driver.git"
export custom_build=false
export require_root=false
export last_tested_commit="ebddb087ef140ca83e4c30d66580b0bb33b003fd"

function run_prep() {
    rm "${builddir}/${package_full}/debian/README.Debian"
    
    if ! command -v dkms &>/dev/null ; then
        echo "dkms not found: ensure that it is installed"
        exit 1
    fi
}
