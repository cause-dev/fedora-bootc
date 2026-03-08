# Start from the official minimal Fedora Bootc
FROM quay.io/fedora/fedora-bootc:latest

RUN --mount=type=bind,source=repos.sh,target=/tmp/repos.sh \
    chmod +x /tmp/repos.sh && /tmp/repos.sh

RUN --mount=type=bind,source=packages.sh,target=/tmp/packages.sh \
    chmod +x /tmp/packages.sh && /tmp/packages.sh


# 2. Enable Desktop Services
RUN systemctl set-default graphical.target && \
    systemctl enable gdm && \
    systemctl enable NetworkManager

# 3. System Configuration (Shell & Sudo)
RUN sed -i 's/SHELL=\/bin\/bash/SHELL=\/usr\/bin\/fish/' /etc/default/useradd && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

RUN bootc container lint
