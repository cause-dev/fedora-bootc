# 🚀 My Custom Fedora Bootc Image

This repository contains the **"Foundations"** of my workstation. It builds a surgically clean, image-based Fedora desktop using the official `bootc` (Image Mode) workflow.

## 🏗️ Architecture
Unlike traditional Fedora Silverblue, this image is built from the minimal `fedora-bootc` base using pure `dnf` logic. It is designed to be **stateless**, **minimal**, and **Flatpak-centric**.

### 📁 File Structure
- `Containerfile`: The OCI blueprint that orchestrates the build.
- `repos.sh`: Configures software sources (RPM Fusion, mise, Flathub).
- `packages.sh`: Handles DNF package/group installation and bloatware exclusion.
- `config.sh`: System-level configurations (Hostname, default shell, passwordless sudo).
- `.github/workflows/`: Automated CI/CD pipeline that builds and pushes the image to GHCR.

---

## 🛠️ Features
- **Minimal GNOME:** Only the core Shell and Settings. No Maps, Weather, Contacts, or Software Store.
- **DNF-Based Build:** Built using standard `dnf` inside the container for faster, more reliable builds.
- **Stateless Configuration:** OS logic is moved to `/usr` where possible to keep `/etc` clean.
- **Zstd:Chunked:** Optimized for delta updates to ensure small, fast downloads on the host.
- **Built-in Tools:** Pre-baked with `fish`, `just`, `distrobox`, and `chezmoi` for immediate bootstrapping.

---

## 🚀 Deployment

### 1. Existing Fedora Atomic Install
If you are already running Fedora Silverblue/Kinoite, you can "switch" to this image:

```bash
# Switch the OS to this image
sudo bootc switch ghcr.io/cause-dev/fedora-bootc:latest
```

### 2. New Machine (ISO Generation)
To install on a new machine, use the `bootc-image-builder` to generate a flashable ISO. 

*Note: Use a local `config.toml` for user creation/passwords.*

```bash
sudo podman run \
    --rm -it --privileged \
    -v $(pwd)/config.toml:/config.toml \
    -v $(pwd)/output:/output \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type iso \
    --config /config.toml \
    --rootfs xfs \
    ghcr.io/cause-dev/fedora-bootc:latest
```

---

## 🔄 Maintenance & Updates

### Automated Builds
This repository uses GitHub Actions to rebuild the image every Saturday at 2 AM. This ensures the image always contains the latest security patches and kernel from Fedora.

### Manual Update
To pull the latest changes on your workstation:
```bash
# Handled via justfile in dotfiles
just update
```
Or manually:
```bash
sudo bootc upgrade
```

---

## 🏠 Home Setup
Once the OS is installed, the "Furniture" (configurations and apps) is applied via my **[Dotfiles Repository](https://github.com/cause-dev/dotfiles)**.

```bash
chezmoi init --apply https://github.com/cause-dev/dotfiles
just setup
```

---

## 📜 License
MIT © [cause-dev]
