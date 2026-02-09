#!/usr/bin/env bash
		set -euo pipefail


	dnf --refresh upgrade -y && \
	dnf group install -y "Development Tools" && \
	dnf install -y \
	ghostscript \
	texlive \
	texlive-beamer \
	texlive-amscls \
	texlive-amsmath \
	texlive-amsfonts \
	texlive-bibtex \
	texlive-makeindex \
	texlive-metafont \
	texlive-cm-super \
	texlive-dvips \
	texlive-bibtex\
	texlive-makeindex \
	texlive-fancyhdr \
	texlive-cm \
	texlive-metafont\
	texlive-ec \
	texlive-cm-super && \
	dnf clean all && \
    echo "DONE dnf install and clean. now syncing." && \
	sync

	RC=$?

#wiki2beamer: use the legacy RPM (The Fedora 38 package)

		if [ ${RC} -eq 0 ]; then
				echo "SUCCESSfully installed packages."
		else
				echo "ERROR installing packages."
        fi

		exit ${RC}

