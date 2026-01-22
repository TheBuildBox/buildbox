#!/usr/bin/env bash
set -euo pipefail


# 1. Ensure we are using the full path and fresh metadata
dnf5 --refresh upgrade -y

#dnf install -y groupinstall
#dnf5 install 'dnf5-command(groupinstall)'
#dnf -y groupinstall "Development Tools"

# 2. Install core tools with explicit 'nodocs' override
# Note: DNF5 doesn't use --saver., we use --setopt instead
dnf5 install -y --setopt=tsflags= \
        git \
        make \
        cmake \
        less \
        dia \
        ghostscript \
        texlive-scheme-full

# 3. Install the specific LaTeX packages
dnf5 install -y \
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
	    ghostscript

#	texlive-amslatex-primer
#	texlive-ams

# # 4. Install the legacy RPM (The Fedora 38 package)
# Quoting the URL to prevent shell interference
dnf5 install -y  https://kojipkgs.fedoraproject.org//packages/wiki2beamer/0.10.0/9.fc38/noarch/wiki2beamer-0.10.0-9.fc38.noarch.rpm

# 5. CRITICAL: Physical Verification
# This forces the build to CRASH here if the files are missing
if [ ! -f /usr/bin/make ]; then
        echo "ERROR: make was not found in /usr/bin!"
        ls -la /usr/bin/ | grep make || echo "No make-related files found"
        exit 1
fi
echo "/usr/bin/make found!"

# 6. Final Flush
dnf5 clean all
sync
