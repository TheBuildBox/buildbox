#!/usr/bin/env bash

set -euo pipefail


		zypper install  -y git gcc make cmake automake autoconf python3 vim less

		RC=$?

		if [ ${RC} -eq 0 ]; then
				echo "successfully installed packages."
		else
				echo "error installing packages."
        fi

		exit ${RC}
