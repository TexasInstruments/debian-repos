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

cd ${projdir}/suite/bookworm/
package_name=$(dpkg-parsechangelog --show-field Source)
deb_version=$(dpkg-parsechangelog --show-field Version)
package_version=$(echo $deb_version | cut -d'-' -f1)
package_full="${package_name}-${package_version}"
package_full_ll="${package_name}_${package_version}"
echo "Building " $package_name " version " $deb_version
cd -

source ${projdir}/version.sh

mkdir -p ${builddir}

if $custom_build ; then
    run_custom_build
    exit 0
fi

if [ $require_root = "true" ] && [ "$EUID" -ne 0 ] ; then
    echo "Requires root privileges to execute"
    echo "Exiting"
    exit 1
fi

mkdir -p "${sourcedir}"

cd ${builddir}
if [ ! -f "${package_full_ll}.orig.tar.gz" ]; then
    if [ ! -d "${sourcedir}/${package_name}" ]; then
        git clone "${git_repo}" "${sourcedir}/${package_name}"
    fi
    git -C "${sourcedir}/${package_name}" checkout "${last_tested_commit}"
    tar -cvzf "${builddir}/${package_full_ll}.orig.tar.gz" \
      --absolute-names "${sourcedir}/${package_name}" \
      --transform "s,${sourcedir}/${package_name},${package_full},"
    tar -xzmf "${package_full_ll}.orig.tar.gz"
fi

cd "${builddir}/${package_full}"
if [ ! -d "debian" ]; then
	debmake
fi

# Deploy our Debian control files
cp -rv "${projdir}/suite/bookworm/debian" "${builddir}/${package_full}/"

run_prep

# Build source package
dpkg-source -b .

# Extract source package
cd "${builddir}"
if [ ! -d "${package_name}_${deb_version}" ]; then
    dpkg-source -x "${package_name}_${deb_version}.dsc" "${package_name}_${deb_version}"
fi

# Build binary package
cd "${package_name}_${deb_version}"
debuild --no-lintian
