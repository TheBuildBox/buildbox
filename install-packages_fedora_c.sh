#!/usr/bin/env bash

		set -euo pipefail


		dnf group install -y development-tools c-development && \
		dnf install  -y git gcc make cmake automake autoconf vim less python3

		RC=$?

		if [ ${RC} -eq 0 ]; then
				echo "successfully installed packages."
		else
				echo "error installing packages."
        fi

		exit ${RC}

