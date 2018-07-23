#!/bin/sh

# Doing this in a separate script lets us do it step by step while using a
# single docker layer.

# Install dependencies
dnf update && \
dnf install -y \
    wget \
    python2-dnf \
    ansible \
    make \
    cmake \
    git \
    which \
    nodejs \
    gcc \
    g++ \
    clang \
    openssl-devel \
    bzip2-devel \
    sudo \
    nss_wrapper \
    gettext;

# apprently this is the only way we can install Python 3.6
cd /usr/src && \
   wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz && \
   tar xzf Python-3.6.3.tgz && \
   cd Python-3.6.3 && \
   ./configure --enable-optimizations && \
   make altinstall && \
   rm -rf /usr/src/Python-3.6.3.tgz && \
   /usr/bin/python3 -V
# Add NVM for Node.js
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 

# Create user
adduser user -u 1000 -g 0 -r -m -d /home/user/ -c "Default Application User" -l
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user
chmod 0440 /etc/sudoers.d/user

# c9 V2 install
cd /opt && \
   git clone https://github.com/exsilium/cloud9 && \
   cd cloud9 && \
   npm i --save;
cd .. && \
   git clone https://github.com/exsilium/cloud9-plugin-ungit.git && \
   git clone https://github.com/exsilium/mungit.git && \
   cd mungit && npm install -g grunt-cli && npm install && grunt && \
   printf '{ "users": { "test": "test" }}' | tee /home/app/.ungitrc && \
cd .. && \
   ln -s /opt/cloud9-plugin-ungit /opt/cloud9/plugins-client/ext.ungit;

# Allow user installs in /opt as root
chmod g+rw /opt
chgrp root /opt

# Create work directory
mkdir -p /workspace
chown user:root /workspace

# allow to run on openshift
chown -R user:root /opt/c9sdk
chmod -R g+rw /opt/c9sdk
chmod -R g+rw /home/user
chgrp -R 0 /home/user && \
chmod a+x /home/user/entrypoint && \
chmod -R g=u /home/user && \
chmod g=u /etc/passwd;
find /home/user -type d -exec chmod g+x {} +

# Clean up
dnf clean all