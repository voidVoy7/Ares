#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# Repos
# Microsoft
rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/vscode.repo
# Terra
sed -i '/^\[terra\]$/,/^\[/{s/^enabled=0$/enabled=1/}' /etc/yum.repos.d/terra.repo
# my4ng
dnf -y config-manager addrepo --from-repofile=https://my4ng.dev/repos/fedora-my4ng.repo



dnf5 install -y tmux
dnf install -y helix
dnf install -y gimp
dnf install -y ghostty
dnf install -y vesktop
dnf install -y code
dnf install -y firefox
dnf install -y openrazer
dnf install -y akmod-openrazer
dnf install -y polychromatic


# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
