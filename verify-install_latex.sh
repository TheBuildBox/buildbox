#!/usr/bin/env bash
set -euo pipefail

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${SCRIPTDIR}/common.sh"



echo "verifying latex install."

echo "1. verifying that make is installed."

verify_binary "make" || exit 1


echo "2. verifying working of commands and availability of the article document class"

make --version && pdflatex --version && kpsewhich article.cls
