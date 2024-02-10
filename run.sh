#!/bin/bash

set -e

if [ "$#" -eq 0 ]; then
    echo "run.sh: missing operands"
    echo "Requires source package name as argument"
    exit 1
fi

DEB_SUITE="${DEB_SUITE:-bookworm}"

topdir=$(git rev-parse --show-toplevel)
projdir="${topdir}/$1"
sourcedir="${topdir}/build/sources"
builddir="${topdir}/build/${DEB_SUITE}/$1"
debcontroldir="${projdir}/suite/${DEB_SUITE}"

if [ ! -d ${projdir} ]; then
    echo "This project does not exist."
    echo "Exiting."
    exit 1
fi

source ${projdir}/version.sh

mkdir -p ${builddir}

if $custom_build ; then
    run_custom_build
    exit 0
fi

package_name=$(cd ${debcontroldir} && dpkg-parsechangelog --show-field Source)
deb_version=$(cd ${debcontroldir} && dpkg-parsechangelog --show-field Version)
package_version=$(echo $deb_version | sed 's/\(.*\)-.*/\1/')
last_tested_commit=$(echo $package_version | sed 's/.*+//')
package_full="${package_name}-${package_version}"
package_full_ll="${package_name}_${package_version}"
echo "Building " $package_name " version " $deb_version

if [ $require_root = "true" ] && [ "$EUID" -ne 0 ] ; then
    echo "Requires root privileges to execute"
    echo "Exiting"
    exit 1
fi

mkdir -p "${sourcedir}"

# Generate original source tarball if none found
if [ ! -f "${builddir}/${package_full_ll}.orig.tar.gz" ]; then
    if [ ! -d "${sourcedir}/${package_name}" ]; then
        git clone "${git_repo}" "${sourcedir}/${package_name}"
    fi
    git -C "${sourcedir}/${package_name}" remote update
    git -C "${sourcedir}/${package_name}" checkout "${last_tested_commit}"
    tar -czf "${builddir}/${package_full_ll}.orig.tar.gz" \
      --exclude-vcs \
      --absolute-names "${sourcedir}/${package_name}" \
      --transform "s,${sourcedir}/${package_name},${package_full},"
fi

# Extract original source tarball
tar -xzmf "${builddir}/${package_full_ll}.orig.tar.gz" -C "${builddir}"

# Add default debian control files if none found
if [ ! -d "${builddir}/${package_full}/debian" ]; then
    (cd "${builddir}/${package_full}" && debmake)
fi

# Deploy our Debian control files
cp -rv "${debcontroldir}/debian" "${builddir}/${package_full}/"

run_prep || true

# Build source package
(cd "${builddir}/${package_full}" && dpkg-source -b .)

# Extract source package
if [ ! -d "${builddir}/${package_name}_${deb_version}" ]; then
    dpkg-source -x "${builddir}/${package_name}_${deb_version}.dsc" "${builddir}/${package_name}_${deb_version}"
fi

# Build binary package
(cd "${builddir}/${package_name}_${deb_version}" && debuild --no-lintian --no-sign)
