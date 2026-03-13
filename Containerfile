# Start from the official minimal Fedora Bootc
FROM quay.io/fedora/fedora-bootc:latest
MAINTAINER cause-dev

# SETUP FILESYSTEM
RUN mkdir /var/roothome

# PREPARE PACKAGES
COPY --chmod=0644 ./system/usr__local__share__fedora-bootc__packages-removed /usr/local/share/fedora-bootc/packages-removed
COPY --chmod=0644 ./system/usr__local__share__fedora-bootc__packages-added /usr/local/share/fedora-bootc/packages-added
RUN jq -r .packages[] /usr/share/rpm-ostree/treefile.json > /usr/local/share/fedora-bootc/packages-fedora-bootc

# INSTALL REPOS
RUN dnf -y install dnf5-plugins

COPY repos.sh /tmp/repos.sh
RUN chmod +x /tmp/repos.sh && /tmp/repos.sh

# INSTALL PACKAGES
RUN grep -vE '^#' /usr/local/share/fedora-bootc/packages-added | xargs dnf -y install --allowerasing

# REMOVE PACKAGES
RUN grep -vE '^#' /usr/local/share/fedora-bootc/packages-removed | xargs dnf -y remove
RUN dnf -y autoremove
RUN dnf clean all

# CONFIGURATION
COPY --chmod=0755 ./system/usr__local__bin/* /usr/local/bin/

# USERS
COPY --chmod=0644 ./system/usr__lib__credstore__home.create.admin /usr/lib/credstore/home.create.admin

COPY --chmod=0755 ./scripts/* /tmp/scripts/
RUN /tmp/scripts/config-users
RUN /tmp/scripts/config-authselect && rm -r /tmp/scripts

# SYSTEMD
COPY --chmod=0644 ./systemd/usr__lib__systemd__system__firstboot-setup.service /usr/lib/systemd/system/firstboot-setup.service

RUN systemctl enable firstboot-setup.service
# Disable auto update
RUN systemctl mask bootc-fetch-apply-updates.timer

# CLEAN & CHECK
RUN find /var/log -type f ! -empty -delete
RUN bootc container lint
