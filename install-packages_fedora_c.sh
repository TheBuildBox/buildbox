#!/usr/bin/env bash


dnf install -y groupinstall
dnf -y groupinstall "Development Tools"
dnf install  -y git gcc make cmake automake autoconf vim
dnf install -y python3


