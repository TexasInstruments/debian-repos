#!/bin/bash

export git_repo="https://github.com/cryptodev-linux/cryptodev-linux.git"
export custom_build=false
export require_root=false
export last_tested_commit="bb8bc7cf60d2c0b097c8b3b0e807f805b577a53f"
export depends="dkms dh-dkms"

function run_prep() {
    if ! command -v dkms &>/dev/null ; then
        echo "dkms not found: ensure that it is installed"
        exit 1
    fi
}
