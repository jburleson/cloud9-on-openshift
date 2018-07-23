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
    nodejs \
    clang \
    openssl-devel \
    bzip2-devel \
    sudo \
    nss_wrapper \
    gettext && \
    dnf group install "C Development Tools and Libraries" -y;
    
# Add NVM for Node.js
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 

# Create user
adduser user -u 1000 -g 0 -r -m -d /home/user/ -c "Default Application User" -l
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user;

cp -vR /root/.bashrc /home/user && \
chown -R user:user /home/user/.bashrc

# c9 V2 install
cd /opt && \
   git clone https://github.com/exsilium/cloud9 && \
   cd cloud9 && \
   npm i --save;
cd .. && \
   git clone https://github.com/exsilium/cloud9-plugin-ungit.git && \
   git clone https://github.com/exsilium/mungit.git && \
   cd mungit && npm install -g grunt-cli && npm install && grunt && \
   printf '{ "users": { "test": "test" }}' | tee /home/user/.ungitrc && \
cd .. && \
   ln -s /opt/cloud9-plugin-ungit /opt/cloud9/plugins-client/ext.ungit;

# Allow user installs in /opt as root
chmod g+rw /opt
chgrp root /opt

# Create work directory
mkdir -p /workspace
chown user:root /workspace

# allow to run on openshift
chown -R user:root /opt/cloud9
chmod -R g+rw /opt/cloud9
chmod -R g+rw /home/user
find /home/user -type d -exec chmod g+x {} +

# Clean up
dnf clean all