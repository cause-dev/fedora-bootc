# Start from the official minimal Fedora Bootc
FROM quay.io/fedora/fedora-bootc:latest

COPY repo.sh /
RUN chmod +x /repo.sh && /repo.sh && rm /repo.sh

COPY packages.sh /
RUN chmod +x /packages.sh && /packages.sh && rm /packages.sh

# 2. Enable Desktop Services
RUN systemctl set-default graphical.target && \
    systemctl enable gdm && \
    systemctl enable NetworkManager

# 3. System Configuration (Shell & Sudo)
RUN sed -i 's/SHELL=\/bin\/bash/SHELL=\/usr\/bin\/fish/' /etc/default/useradd && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

RUN bootc container lint
