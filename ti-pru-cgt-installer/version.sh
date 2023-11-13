#!/bin/bash

export custom_build=true
export require_root=false

function run_custom_build() {
    mkdir -p "${builddir}/${package_name}_${deb_version}"
    cp -r "${debcontroldir}"/* "${builddir}/${package_name}_${deb_version}"
    (cd "${builddir}/${package_name}_${deb_version}" && debuild --no-lintian -i -us -uc -b)
}
