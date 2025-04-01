SHELL := /usr/bin/env bash

IMAGE_REGISTRY ?= quay.io
REGISTRY_NAMESPACE ?= buildbox

IMAGE_TAG ?= latest
IMAGE_OS ?= fedora
IMAGE_LANG ?= c
IMAGE_NAME ?= buildbox/$(IMAGE_OS)-$(IMAGE_LANG)
INSTALL_DIR ?= /usr/local/bin

IMG  ?= $(IMAGE_REGISTRY)/$(REGISTRY_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG)

# detect whether to use docker or podman as container command.
ifeq ($(origin CONTAINER_CMD),undefined)
# try podman first
CONTAINER_CMD=$(shell podman version >/dev/null 2>&1 && echo podman)
ifeq ($(CONTAINER_CMD),)
#try docker if podman is not available
CONTAINER_CMD=$(shell docker version >/dev/null 2>&1 && echo docker)
endif
endif


.PHONY: vars
vars:
	@echo CONTAINER_CMD: $(CONTAINER_CMD)
	@echo IMG: $(IMG)

.PHONY: image-build
image-build:
	$(CONTAINER_CMD) build -t $(IMG) --build-arg BUILD_LANG=$(IMAGE_LANG) --build-arg INSTALL_SCRIPT=install-packages_$(IMAGE_OS)_$(IMAGE_LANG).sh  -f Containerfile.$(IMAGE_OS) .


.PHONY: image-push
image-push:
	$(CONTAINER_CMD) push $(IMG) 



.PHONY: install-cli
install-cli:
	@install ./builbo $(INSTALL_DIR)

.PHONY: test
	test: check

.PHONY: check

check: checkmake

.PHONY: makeckmake
checkmake:
	checkmake Makefile

.PHONY: clean

clean:
	@echo "Note: no generated files.  not cleaning. use git to clean."
