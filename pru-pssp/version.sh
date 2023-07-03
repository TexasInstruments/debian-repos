#!/bin/bash

export git_repo="https://git.ti.com/git/pru-software-support-package/pru-software-support-package.git"
export package_name="pru-pssp"
export package_version="6.1"
export package_full="${package_name}-${package_version}"
export custom_build=false
export require_root=true
export last_tested_commit="75e974590eac2e38b53686e97018c47fc1147042"

function copy_files() {
    cp -rv "${projdir}/suite/bookworm/debian/patches" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/rules" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/copyright" "${builddir}/${package_full}/debian/"
    cp -rv "${projdir}/suite/bookworm/debian/source" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/changelog" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/control" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/watch" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/libpru-pssp-dev.install" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/pru-pssp.install" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/pru-pssp.lintian-overrides" "${builddir}/${package_full}/debian/"
    cp -v "${projdir}/suite/bookworm/debian/pru-pssp-dev.lintian-overrides" "${builddir}/${package_full}/debian/"
}

function setup_cgt_pru() {
    cd ${builddir}

    if [ ! -f ti_cgt_pru_2.3.3_armlinuxa8hf_busybox_installer.sh ] ; then
        wget "https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-FaNNGkDH7s/2.3.3/ti_cgt_pru_2.3.3_armlinuxa8hf_busybox_installer.sh"
    fi

    chmod +x ti_cgt_pru_2.3.3_armlinuxa8hf_busybox_installer.sh
    if [ ! -d "/usr/share/ti/cgt-pru" ] ; then
        ./ti_cgt_pru_2.3.3_armlinuxa8hf_busybox_installer.sh
    fi
    export PRU_CGT="/usr/share/ti/cgt-pru"

    if [ ! -L "/usr/bin/cgt-pru" ] ; then
        ln -s /usr/bin/ /usr/share/ti/cgt-pru/bin
    fi

    cd "${builddir}/${package_full}"
}
    

function run_prep() {
    copy_files
    setup_cgt_pru 
}
