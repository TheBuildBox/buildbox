#!/usr/bin/env bash
		set -euo pipefail


	dnf --refresh upgrade -y && \
	dnf group install -y development-tools && \
	dnf install -y --setopt=tsflags= \
	git \
	make \
	cmake \
	less \
	dia \
	ghostscript \
	texlive-scheme-full \
	texlive \
	pdflatex \
	texlive-beamer \
	texlive-amsmath \
	texlive-amsfonts \
	texlive-bibtex \
	texlive-makeindex \
	texlive-metafont \
	texlive-cm-super \
	texlive-dvips \
	texlive-amsaddr \
	texlive-amscls \
	texlive-amsmath \
	texlive-amsfonts \
	texlive-amsrefs  \
	texlive-amscdx \
	texlive-xypic \
	texlive-bibtex\
	texlive-imakeidx \
	texlive-makeindex \
	texlive-indextools \
	texlive-hyperxmp \
	texlive-fancyhdr \
	texlive-cm \
	texlive-bbm \
	texlive-cm-mf-extra-bold \
	texlive-metafont\
	texlive-ec \
	texlive-cm-super \
	texlive-ginpenc \
	texlive-latex-uni8 \
	texlive-german \
	texlive-amslatex-primer-doc && \
	dnf -y install "https://kojipkgs.fedoraproject.org//packages/wiki2beamer/0.10.0/9.fc38/noarch/wiki2beamer-0.10.0-9.fc38.noarch.rpm" && \
	dnf clean all && \
    ech "done dnf install and clean. now syncing." && \
	sync

	RC=$?

#wiki2beamer: use the legacy RPM (The Fedora 38 package)

		if [ ${RC} -eq 0 ]; then
				echo "successfully installed packages."
		else
				echo "error installing packages."
        fi

		exit ${RC}

