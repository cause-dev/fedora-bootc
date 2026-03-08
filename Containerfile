# Start from the official minimal Fedora Bootc
FROM quay.io/fedora/fedora-bootc:latest

COPY repos.sh /tmp/repos.sh
RUN chmod +x /tmp/repos.sh && /tmp/repos.sh

COPY packages.sh /tmp/packages.sh
RUN chmod +x /tmp/packages.sh && /tmp/packages.sh

# Run all the configurations
COPY config.sh /tmp/config.sh
RUN chmod +x /tmp/config.sh && /tmp/config.sh

# 2. Enable Desktop Services
RUN systemctl set-default graphical.target && \
    systemctl enable gdm && \
    systemctl enable NetworkManager

# 3. System Configuration (Shell & Sudo)
RUN sed -i 's/SHELL=\/bin\/bash/SHELL=\/usr\/bin\/fish/' /etc/default/useradd && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

RUN bootc container lint
