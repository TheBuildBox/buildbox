#!/usr/bin/env bash

set -euo pipefail

		zypper install  -y git gcc make cmake automake autoconf python3 vim less && \
		sync

		RC=$?
		echo "DONE installing packages"
		echo "return code: ${RC}"

		if [ ${RC} -eq 0 ]; then
				echo "SUCCESSfully installed packages."
		else
				echo "ERROR installing packages."
		fi


		exit ${RC}
