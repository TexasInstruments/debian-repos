#!/bin/bash

export git_repo="https://git.ti.com/git/ti-linux-kernel/ti-linux-kernel.git"
export package_name="ti-linux-kernel"
export package_version="6.1"
export package_full="${package_name}-${package_version}"
export custom_build=true
export require_root=false
export release_tag="09.00.00.006"

function run_custom_build() {
    cd "${builddir}"
    if [ ! -d ${package_name} ]; then
		git clone "${git_repo}" -b "${release_tag}" --single-branch --depth=1
    fi

    cd ti-linux-kernel

    if [ ! -f ".config" ]; then
        make defconfig ti_arm64_prune.config
    fi

    make bindeb-pkg
}
