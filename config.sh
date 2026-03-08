#!/bin/bash
set -ouex pipefail

# Set Hostname
mkdir -p /usr/lib/tmpfiles.d
echo 'L /etc/hostname - - - - ../usr/lib/hostname' > /usr/lib/tmpfiles.d/hostname.conf
echo "dev" > /usr/lib/hostname

# Set Default Shell (Fish)
sed -i 's/SHELL=\/bin\/bash/SHELL=\/usr\/bin\/fish/' /etc/default/useradd

# Enable Sudo for Wheel Group (Passwordless)
echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

