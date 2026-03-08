#!/bin/bash
set -ouex pipefail


mkdir -p /usr/share/flatpak/remotes.d
curl -o /usr/share/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo


dnf -y clean all
