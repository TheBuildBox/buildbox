#!/usr/bin/env bash


 dnf upgrade -y
#dnf install -y groupinstall
#dnf5 install 'dnf5-command(groupinstall)'
#dnf -y groupinstall "Development Tools"
dnf install  -y git make cmake texlive-beamer


# orphaned package: use old build as workaround.
dnf install -y  https://kojipkgs.fedoraproject.org//packages/wiki2beamer/0.10.0/9.fc38/noarch/wiki2beamer-0.10.0-9.fc38.noarch.rpm



