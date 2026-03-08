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

RUN bootc container lint
