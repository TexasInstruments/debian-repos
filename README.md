# Debian-Repos

Debian-Repos is a set of scripts to build TI's Debian packages with a single
command.

The generation of a Debian package (binary and source) involves many steps, such
as obtaining the tar of the source code, generating template files, modifying
template files and the build system, setting environment variables etc. The
`run.sh` script handles these steps, thus the building of a deb package for TI's
packages is as simple as running `run.sh` with the desired package's name.

This repository is useful to the following audience:
1. Potential package contributors who want to fix bugs or add enhancements to
TI packages
2. Users who want a package with the latest changes to the master branch
3. Anyone who wants to study Debian packaging

## Structure and HowTo Use:

The `run.sh` file is the "main" script that should be run. It takes as argument
the name of the package to be built.

Each TI package has a corresponding directory, named after its source package.
Within this directory exists the `suite/<distro-variant>/debian/` path. All
Debian related files (`control`, `rules`, man pages etc) for the package are
located here.

There also exists a `<package-name>/version.sh` file. This file is sourced by
`run.sh`. It exports a bunch of variables for `run.sh` to use. It also contains
a `run_prep` function, which `run.sh` calls. `run_prep` carries out all
package-specific operations needed to build the deb files.

To build a package, the syntax is:

```sh
./run.sh <package-name>
```

> [!NOTE]  
> The default suite is `trixie`. To build for `bookworm`, set `DEB_SUITE` to 
> `bookworm` in your environment
>
> ```sh
> DEB_SUITE=bookworm ./run.sh <package-name>
> ```

This command carries out all necessary steps to build the package. The
package and all related files are then stored in `build/<package-name>`.
Note that certain packages may require root privileges.

For example: to build `ti-linux-kernel`, the command is:

```sh
./run.sh ti-linux-kernel
```

The output is then found in `build/ti-linux-kernel/`.
