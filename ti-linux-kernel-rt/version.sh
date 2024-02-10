#!/bin/bash

export git_repo="https://git.ti.com/git/ti-linux-kernel/ti-linux-kernel.git"
export custom_build=true
export require_root=false
export release_tag="09.02.00.001-rt"
export package_name="linux-upstream"

export DEBFULLNAME="Sai Sree Kartheek Adivi"
export DEBEMAIL="s-adivi@ti.com"
export KDEB_CHANGELOG_DIST=bookworm

function run_custom_build() {
    cd "${builddir}"
    if [ ! -d ${package_name} ]; then
        git clone "${git_repo}" -b "${release_tag}" --single-branch --depth=1 ${package_name}
    fi

    cd ${package_name}
    
    if [ ! -f ".config" ]; then
        make -j $((`nproc`-2)) defconfig ti_arm64_prune.config ti_rt.config
	
    fi

    make -j $((`nproc`-2)) bindeb-pkg LOCALVERSION=-k3-rt
}
