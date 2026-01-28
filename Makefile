SHELL := /usr/bin/env bash

IMAGE_REGISTRY ?= quay.io
REGISTRY_NAMESPACE ?= buildbox

IMAGE_TAG ?= latest
IMAGE_OS ?= fedora
IMAGE_LANG ?= c
IMAGE_NAME ?= buildbox/$(IMAGE_OS)-$(IMAGE_LANG)
NSTALL_DIR ?= /usr/local/bin

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

CHECKMAKE=go run github.com/checkmake/checkmake/cmd/checkmake@latest

include cli/Makefile

define HELPTEXT
Options:
	IMAGE_TAG			tag to use for the image (default: latest)
	IMAGE_OS			base OS for the image(fedora|suse|debian|ubuntu) (default: fedora
	IMAGE_LANG			programming language to create image for (c|latex) (default: c)
	CONTAINER_CMD			container command (podman|docker) (default: auto-detected)
	IMAGE_REGISTRY			container registry to use (default: quay.io)
	REGISTRY_NAMESPACE		container registry namespace (default: buildbox)
endef
export HELPTEXT


.PHONY: all

all: help ## default target (invokes help)

.PHONY: vars
vars: vars1 vars2 ## print values of some variables.

.PHONY: vars1
vars1: ## print values of some variables (part 1)
	@echo IMAGE_TAG: $(IMAGE_TAG)
	@echo IMAGE_OS: $(IMAGE_OS)
	@echo IMAGE_LANG $(IMAGE_LANG)
.PHONY: vars2
vars2: ## print values of some variables (part 2)
	@echo IMAGE_REGISTRY $(IMAGE_REGISTRY)
	@echo REGISTRY_NAMESPACE $(REGISTRY_NAMESPACE)
	@echo CONTAINER_CMD: $(CONTAINER_CMD)
	@echo IMG: $(IMG)

.PHONY: image-build
image-build: ## build a container image.
	$(CONTAINER_CMD) build --no-cache --progress=plain -t $(IMG) --build-arg BUILD_LANG=$(IMAGE_LANG) --build-arg INSTALL_SCRIPT=install-packages_$(IMAGE_OS)_$(IMAGE_LANG).sh  -f Containerfile.$(IMAGE_OS) .


.PHONY: image-push 
image-push: ## push a container image to the registry.
	$(CONTAINER_CMD) push $(IMG) 



.PHONY: install-cli
install-cli:$(INSTALL_PATH) ## install the builbo cli.
#	@install ./builbo $(INSTALL_DIR)

.PHONY: test
	test: check ## perform tests (checks/linting).


.PHONY: shellcheck
shellcheck: shellcheck-cli ## lint shell scripts

	shellcheck --severity=warning --format=gcc --shell=bash  $(shell find .  -type f -name '*.sh') 

.PHONY: check
check: checkmake shellcheck  ## perform checks and linting

.PHONY: makeckmake
checkmake: ## lint the Makefile with checkmake.
	$(CHECKMAKE) Makefile

.PHONY: clean

clean: ## clean the working directory (currently vain).
	@echo "Note: no generated files.  not cleaning. use git to clean."

.PHONY: help
help: ## Show usage info  for the Makefile targets.
	@echo  "Usage: make [OPTION1=value OPTION2=value  ...] [TARGET ...]"
	@echo " Available targets:"
	@grep --no-filename -E '^[a-zA-Z0-9_%-. ]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo "$$HELPTEXT"


