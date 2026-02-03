#!/usr/bin/env bash
set -euo pipefail

		SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

		source "${SCRIPTDIR}/common.sh"

		echo "verifying c install."

		echo "1. verifying that make is installed."

		verify_binary "make" || exit 1

		echo "2. veifying that gcc is installed."
		verify_binary "gcc" || exit 1


echo "2. verifying working of commands"

make --version && gcc --version
