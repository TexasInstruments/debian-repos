#!/bin/bash

export git_repo="https://github.com/cryptodev-linux/cryptodev-linux.git"
export custom_build=false
export require_root=false

function run_prep() {
    if ! command -v dkms &>/dev/null ; then
        echo "dkms not found: ensure that it is installed"
        exit 1
    fi
}
