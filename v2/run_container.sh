#!/bin/sh

# Doing this in a separate script lets us do it step by step while using a
# single docker layer.

# Install dependencies
dnf -y install "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" && \ 
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
    clang \
    openssl-devel \
    bzip2-devel \
    sudo \
    nss_wrapper \
    gettext && \
    dnf group install "C Development Tools and Libraries" -y;
    
# Add NVM for Node.js
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# To prevent API incompatibilities
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
dnf install -y nodejs

# Create user
adduser user -u 1000 -g 0 -r -m -d /home/user/ -c "Default Application User" -l
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user;

cp -vR /root/.bashrc /home/user && \
chown -R 1000:1000 /home/user/.bashrc

# Allow user installs in /opt as root
chmod g+rw /opt
chgrp root /opt

# Create work directory
mkdir -p /workspace
chown -R user:root /workspace
chmod -R g+rw /workspace

# allow to run on openshift
chown -R user:root /opt/cloud9
chmod -R g+rw /opt/cloud9
chmod -R g+rw /home/user
find /home/user -type d -exec chmod g+x {} +

# Clean up
dnf clean all
printf '{ "users": { "test": "test" }}' | tee /home/user/.ungitrc