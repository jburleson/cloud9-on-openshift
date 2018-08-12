#!/bin/sh


# Doing this in a separate script lets us do it step by step while using a
# single docker layer.

# Install dependencies
dnf -y install "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
dnf -y update && \
dnf -y install \
    wget \
    python2-dnf \
    ansible \
    make \
    cmake \
    git \
    which \
    python2 \
    python3 \
    nodejs \
    clang \
    openssl-devel \
    bzip2-devel \
    sudo \
    gettext && \
    dnf group install "C Development Tools and Libraries" -y;

# Create user
adduser user -u 1000 -g 0 -r -m -d /home/user/ -c "Default Application User" -l
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user

# Ansible deployment
# curl -sSL https://github.com/gbraad/ansible-playbooks/raw/master/playbooks/install-c9sdk.yml -o /tmp/install.yml
# su - user -c "ansible-playbook /tmp/install.yml"
cd /opt & \
    git clone https://github.com/c9/core && \
    cd /opt/core && \
    su - user -c "bash /opt/core/scripts/install-sdk.sh" && \
    cd /;

# Allow user installs in /opt as root
chmod g+rw /opt
chgrp root /opt

# Create work directory
mkdir -p /workspace
chown -R user:root /workspace
chmod -R g+rw /workspace

# allow to run on openshift
chown -R user:root /opt/core
chmod -R g+rw /opt/core
chmod -R g+rw /home/user
find /home/user -type d -exec chmod g+x {} +

# Clean up
dnf clean all