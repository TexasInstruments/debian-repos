#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "run.sh: missing operands"
    echo "Requires source package name as argument"
    exit 1
fi

topdir=$(git rev-parse --show-toplevel)
projdir="${topdir}/$1"
builddir="${topdir}/build/$1"
sourcedir="${builddir}/sources"

if [ ! -d ${projdir} ]; then
    echo "This project does not exist."
    echo "Exiting."
    exit 1
fi

mkdir -p "${sourcedir}"

source ${projdir}/version.sh

if $custom_build ; then
    run_custom_build
    exit 0
fi

if [ $require_root ] && [ "$EUID" -ne 0 ] ; then
    echo "Requires root privileges to execute"
    echo "Exiting"
    exit 1
fi

cd ${builddir}
if [ ! -f "${package_full}.tar.gz" ]; then
    cd "${sourcedir}"
    if [ ! -d "${package_full}" ]; then
        git clone "${git_repo}" "${package_full}"
    fi
    cd "${package_full}"
    git checkout "${last_tested_commit}"
    cd -
    tar -cvzf "${builddir}/${package_full}.tar.gz" "${package_full}"
    cd ${builddir}
    tar -xzmf "${package_full}.tar.gz"
fi

cd "${builddir}/${package_full}"
if [ ! -d "debian" ]; then
	debmake
fi

run_prep

# Apply un-applied Debian patches
patch_dir="${builddir}/${package_full}/debian/patches"
while read -r patch; do
    if [ -f "${builddir}/series" ]; then
        if ! grep -Fxq "$patch" "${builddir}/series" ; then
            continue
        fi
    fi
    git apply --check "${patch_dir}/${patch}" --verbose --reject
done < "${patch_dir}/series"
cp "${patch_dir}/series" "${builddir}"

debuild --no-lintian
