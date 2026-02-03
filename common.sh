#!/usr/bin/env bash

function verify_binary() {
 
		local PROG="$1"

		echo "checking for '${PROG}'"

		local FILEPATH="/usr/bin/${PROG}"
		if ls -l "${FILEPATH}" ; then
				echo "Success: ${FILEPATH} found"
				echo "Verification:checking for ${PROG} in PATH"
				if type -p "${PROG}" ; then
						echo "Success: ${PROG} found at $(type -p "${PROG}")"
						return 0
				else
						echo "CRITICAL: ${PROG} is NOT in PATH. Current PATH: $PATH"
						ls -ld /bin /usr/bin
						return 1
				fi
		fi

}
