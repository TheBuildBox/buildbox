#!/usr/bin/env bash
set -euo pipefail


echo "verifying latex install."

echo "checking for 'make'"
if ls -l /usr/bin/make ; then
	echo "/usr/bin/make found"
	echo "Verification:checking for make in PATH"
	if type -p make; then
		echo "Success: make found at $(type -p make)"
	else
		echo "CRITICAL: make is NOT in PATH. Current PATH: $PATH"
		ls -ld /bin /usr/bin 
		exit 1
	fi
fi


echo "verifying commands and latexclass"

make --version && pdflatex --version && kpsewhich article.cls
