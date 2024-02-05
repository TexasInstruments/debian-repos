#!/bin/bash

export git_repo="https://git.ti.com/git/pru-software-support-package/pru-software-support-package.git"
export require_root=true

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
    setup_cgt_pru 
}
