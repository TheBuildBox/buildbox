
[![Build Status](https://github.com/checkmake/checkmake/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/TheBuildBox/buildbox/actions)
[![GPL license](https://img.shields.io/badge/license-GPL-blue.svg)](http://opensource.org/licenses/GPL)



The purpose of this project is to provide container images that can be used to compile/build and package software projects
along with accompanying cli tooling to facilitate convenient execution of builds in those containers.

Note that the focus is not on working interactively but  instead on compiling/building with an intention
to provide tooling for creating deterministic and reproducible builds

It is however of course possible to use the images interactively.




**planned characteristics:**

**OS flavors:**
* Fedora Linux
* Debian/Ubuntu Linux
* maybe opensuse Linux

**Language types:/installed tools**

* c: C(gcc) and make/autotools/Cmake - for building C language projects
* maybe: cpp: make tools an compiler for C++ projects
* go: golang and make - for building golang projects
* latex: LaTeX/beamer/wiki2beamer and make - build LaTeX documents and LaTeX/beamer presentations

**possible future variants:**

* container image packaging
* rpm packaging
* deb packaging


Of these combinations, only the c and latex  images on fedora, debian, ubuntu, and openSUSE  are   implemented so far.


In order to build or use these container images,  one will need a system (typically Linux or MacOS) with docker or podman and `make`installed  and the ability to run bash scripts.






**Example how to build and publish fedora based image for compiling C projects:**

```console

$ make  IMAGE_LANG=c IMAGE_OS=fedora IMAGE_REGISTRY=quay.io REGISTRY_NAMESPACE=fillme image-build
$ podman login quay.io
$ make  IMAGE_LANG=c IMAGE_OS=fedora IMAGE_REGISTRY=quay.io REGISTRY_NAMESPACE=fillme image-push


```

Note that `quay.io` is the default registry and `buildbox` the default namespace . The above example shows how to override them.

**Using the image:**

From the root of a software project that one wants to compile, arbitrary commands contained in the image   can be run inside the build container
as follows, for example `configure`and `make` as well as installation of library dependencies.

Example for starting an interactive shell:

```console

$ podman  run -it --workdir /work --mount type=bind,source=$(pwd),target=/work,relabel=private  --workdir /work quay.io/fillme/devcontainer/fedora-c:latest  bash  

```

It works correspondingly with docker.

prepuilt fedora, debian,  ubuntu, and openSUSE  images for c and latex   images are available on quay:

* [fedora-c](https://quay.io/repository/buildbox/buildbox/fedora-c).
* [debian-c](https://quay.io/repository/buildbox/buildbox/debian-c).
* [ubuntu-c](https://quay.io/repository/madam/buildbox/ubuntu-c).
* [suse-c](https://quay.io/repository/madam/buildbox/suse-c).
* [fedora-latex](https://quay.io/repository/buildbox/buildbox/fedora-latex).
* [debian-latex](https://quay.io/repository/buildbox/buildbox/debian-latex).
* [ubuntu-latex](https://quay.io/repository/buildbox/buildbox/ubuntu-latex).
* [suse-latex](https://quay.io/repository/buildbox/buildbox/suse-latex).


**builbo cli:**

Apart from tooling to create container images, the project provides a cli tool `builbo` to facilitate building software projects in the buildbox containers.

example workflow:

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


