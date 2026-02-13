
[![Build Status](https://github.com/TheBuildBox/buildbox/workflows/vuild-example-projects.yml/badge.svg?branch=main)](https://github.com/TheBuildBox/buildbox/actions)
[![GPL license](https://img.shields.io/badge/license-GPL-blue.svg)](http://opensource.org/licenses/GPL)


# About This Project


This project provides cli tooling to build and possibly package software projects in containers using  pre-created specialized container images.


It additionally provides meachanisms to create custom images.


Note that the focus is not on working interactively but  instead on compiling/building with an intention
to provide tooling for creating deterministic and reproducible builds

It is however of course also possible to use the images interactively.




## Existing and Planned  Image  Characteristics

### Existing OS flavors
* Fedora Linux
* Debian Linux
* Ubuntu Linux
* openSUSE Linux
* Rocky Linux

### Existing Language variants/installed tools

* `c`: C compiler (gcc) and make/autotools/Cmake - for building C language projects
* `latex`: LaTeX/beamer/wiki2beamer and make - build LaTeX documents and LaTeX/beamer presentations

### Possible Future Variants

* cpp: make tools and compiler for C++ projects
* go: golang and make - for building golang projects
* rpm packaging
* deb packaging
* container image packaging


Of these combinations, only the c and latex  images on fedora, debian, ubuntu, and openSUSE  are   implemented so far.


In order to build or use these container images,  one will need a Unix-like system (typically Linux or MacOS) with docker or podman and `make` installed  and the ability to run bash scripts.




## Creating Custom Images

**Example how to build and publish fedora based image for compiling C projects:**

```console

$ make  CONTAINER_CMD=podman IMAGE_LANG=c IMAGE_OS=fedora IMAGE_REGISTRY=quay.io REGISTRY_NAMESPACE=fillme image-build
$ podman login quay.io
$ make  CONTAINER_CMD=podman IMAGE_LANG=c IMAGE_OS=fedora IMAGE_REGISTRY=quay.io REGISTRY_NAMESPACE=fillme image-push


```

Note that `quay.io` is the default registry and `buildbox` the default namespace. The above example shows how to override them.

the container command (docker or podman) used for building the image  is auto-detected by default with a preference for podman.
The above example shows how to override it with the `CONTAINER_CMD`variable.

The image tag to identify the image  is by default constructed as

`$IMAGE_REGISTRY/$REGISTRY_NAMESPACE/$IMAGE_OS-$IMAGE_LANG:latest`.

The `OS-LANG` part can be overridden with the  `IMAGE_NAME` variable.

The  version tag `latest` can be overridden with the `IMAGE_TAG` variable.

The entire tag can be overridden with the `IMG` variable. 











## Using the images

From the root of a software project that one wants to compile, arbitrary commands contained in the image can be run inside the build container
as follows, for example `configure`and `make` as well as installation of library dependencies.

Example for starting an interactive shell:

```console

$ podman  run -it --workdir /work --mount type=bind,source=$(pwd),target=/work,relabel=private  --workdir /work quay.io/fillme/devcontainer/fedora-c:latest  bash  

```

It works correspondingly with docker.


## Prebuilt Images On quay

prebuilt fedora, debian,  ubuntu, and openSUSE  images for c and latex   are available on quay:

* [fedora-c](https://quay.io/repository/buildbox/buildbox/fedora-c).
* [debian-c](https://quay.io/repository/buildbox/buildbox/debian-c).
* [ubuntu-c](https://quay.io/repository/madam/buildbox/ubuntu-c).
* [suse-c](https://quay.io/repository/madam/buildbox/suse-c).
* [fedora-latex](https://quay.io/repository/buildbox/buildbox/fedora-latex).
* [debian-latex](https://quay.io/repository/buildbox/buildbox/debian-latex).
* [ubuntu-latex](https://quay.io/repository/buildbox/buildbox/ubuntu-latex).
* [suse-latex](https://quay.io/repository/buildbox/buildbox/suse-latex).


## builbo cli 

Apart from tooling to create container images, the project provides a cli tool `builbo` to facilitate building software projects in the buildbox containers.

**example workflow for building:** 

```console
$ git clone project
$ cd project_dir
$ edit build.sh
$ builbo -c -l c -o debian -s ./build.sh --build
...
$
```
instead of creating a `build.sh` script, commands can be given directly like this:

```console
$ git clone project
$ cd project_dir
$ builbo -c -l c -o debian  -b -s "./configure && make"
...
$
```



As a result of this process, build artifacts will be placed under  the CWD (project checkout dir).


example for using the container interactively with the `--enter`or `-e` parameter:

```console
$ git clone project
$ cd project_dir
$ builbo -c -l c -o debian --enter
# ^D
$
```

## install builbo (on macOS or Linux)

The following command requires sudo privileges and will install the builbo executable under `/usr/local/bin`


```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/TheBuildBox/install/HEAD/install.sh)"



