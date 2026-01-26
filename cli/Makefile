# 1. Identify the directory this file lives in
# If included, it's the path to this file. If run directly, it's '.'
SELF_DIR := $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))

# 2. Define the binary relative to that path
# When run from root: cli/builbo | When run from cli/: ./builbo
CLI_BIN := $(SELF_DIR)/builbo

INSTALL_DIR ?=/usr/local/bin
INSTALL_PATH :=$(INSTALL_DIR)/builbo

# This is the actual "work" target
$(INSTALL_PATH): $(CLI_BIN)
	@echo "Installing $(CLI_BIN) to $(INSTALL_PATH)..."
	@install -m 755 $(CLI_BIN) $(INSTALL_PATH)


# Standalone convenience target
 .PHONY: install
install: $(INSTALL_PATH)


.PHONY: shellcheck-cli
shellcheck-cli: ## lint shell scripts
	shellcheck --severity=warning --format=gcc --shell=bash $(CLI_BIN)
