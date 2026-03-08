# Start from the official minimal Fedora Bootc
FROM quay.io/fedora/fedora-bootc:latest

COPY repo.sh /tmp/repo.sh
RUN chmod +x /tmp/repo.sh && /tmp/repo.sh && rm /tmp/repo.sh

COPY packages.sh /tmp/packages.sh
RUN chmod +x /tmp/packages.sh && /tmp/packages.sh && rm /tmp/packages.sh

# 2. Enable Desktop Services
RUN systemctl set-default graphical.target && \
    systemctl enable gdm && \
    systemctl enable NetworkManager

# 3. System Configuration (Shell & Sudo)
RUN sed -i 's/SHELL=\/bin\/bash/SHELL=\/usr\/bin\/fish/' /etc/default/useradd && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

RUN bootc container lint
