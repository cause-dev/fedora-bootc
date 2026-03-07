#!/bin/bash
set -ouex pipefail

# 1. Define Groups to install
MY_GROUPS=(
    "@base-graphical"
    "@container-management"
    "@core"
    "@fonts"
    "@gnome-desktop"
    "@hardware-support"
    "@multimedia"
    "@networkmanager-submodules"
    "@desktop-accessibility"
    "@guest-desktop-agents"
    "@workstation-product"
)

# 2. Define Individual Packages to install
MY_PACKAGES=(
    fish
    distrobox
    android-tools
)

# 3. Define Packages to EXCLUDE (Bloatware)
EXCLUDES=(
    gnome-boxes
    libreoffice*
    gnome-connections
    gnome-software*
    gnome-text-editor
    yelp
    gnome-contacts
    gnome-maps
    gnome-weather
    snapshot
    gnome-tour
    gnome-user-docs
    gnome-characters
    gnome-font-viewer
    gnome-logs
    loupe
    papers
    showtime
    snapshot
    simple-scan
    baobab
    yelp
    decibels
    unoconv
)

# Build the dnf command
# Prefixing each exclude with -x
EXCLUDE_FLAGS=()
for pkg in "${EXCLUDES[@]}"; do
    EXCLUDE_FLAGS+=("-x" "$pkg")
done

# Execute installation
dnf -y install "${MY_GROUPS[@]}" "${EXCLUDE_FLAGS[@]}"
dnf -y install "${MY_PACKAGES[@]}"

# Cleanup
dnf -y clean all
