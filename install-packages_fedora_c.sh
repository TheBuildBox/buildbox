#!/usr/bin/env bash


sudo dnf install -y groupinstall
sudo dnf -y groupinstall "Development Tools"
sudo dnf install  -y git gcc make cmake automake autoconf vim
sudo dnf install -y python3


