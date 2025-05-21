#!/usr/bin/env bash


 dnf upgrade -y
#dnf install -y groupinstall
#dnf5 install 'dnf5-command(groupinstall)'
#dnf -y groupinstall "Development Tools"
dnf install  -y git make cmake less \
	pdflatex \
	texlive-beamer \
	texlive-dvips \
	texlive-amsaddr \
	texlive-amscls \
	texlive-amsmath \
	texlive-amsfonts \
	texlive-amsrefs texlive-ams \
	texlive-amscdx \
	texlive-amslatex-primer \
	texlive-xypic \
	texlive-bibtex\
	 texlive-imakeidx \
	 texlive-makeindex \
	 texlive-ginpenc \
	 texlive-latex-uni8 \
	 texlive-german \
	ghostscript


# orphaned package: use old build as workaround.
dnf install -y  https://kojipkgs.fedoraproject.org//packages/wiki2beamer/0.10.0/9.fc38/noarch/wiki2beamer-0.10.0-9.fc38.noarch.rpm



