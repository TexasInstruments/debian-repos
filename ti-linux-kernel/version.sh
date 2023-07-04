#!/bin/bash

export git_repo="https://git.ti.com/git/ti-linux-kernel/ti-linux-kernel.git"
export package_name="ti-linux-kernel"
export package_version="6.1"
export package_full="${package_name}-${package_version}"
export custom_build=true
export require_root=false
export last_tested_commit="2b6f5746de558d954e42749b898fcdb4227dce5a"

function run_custom_build() {
    cd "${builddir}"
    if [ ! -d ${package_name} ]; then
        git clone "${git_repo}"
    fi

    cd ti-linux-kernel
    git checkout "$last_tested_commit"

    if [ ! -f generate-image.patch ]; then
        cp "${projdir}/generate-image.patch" "${builddir}/ti-linux-kernel"
        git apply generate-image.patch
    fi
    
    if [ ! -f ".config" ]; then
        make defconfig ti_arm64_prune.config
    fi

    make bindeb-pkg
}
