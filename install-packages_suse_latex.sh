#!/usr/bin/env bash

		set -euo pipefail

		zypper  install  -y git make cmake  texlive-beamer \
		texlive-dvips \
		texlive-amscls \
		texlive-amsaddr \
		texlive-amsfonts \
		texlive-amscdx \
		texlive-amslatex-primer \
		texlive-amsmath \
		texlive-amsrefs \
		texlive-amstex \
		texlive-xypic \
		texlive-bibtex \
		texlive-imakeidx \
		texlive-makeindex \
		texlive-latex-uni8 \
		texlive-ginpenc \
		texlive-german \
		texlive-hyperxmp \
		texlive-fancyhdr \
		ghostscript vim less dia && \
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



