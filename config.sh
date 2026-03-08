#!/bin/bash
set -ouex pipefail

# Set Hostname
echo "dev" > /etc/hostname

# Set Default Shell (Fish)
sed -i 's/SHELL=\/bin\/bash/SHELL=\/usr\/bin\/fish/' /etc/default/useradd

# Enable Sudo for Wheel Group (Passwordless)
echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

