#!/bin/bash

# Define variables
PE_VERSION="2019.8.6"
DIST="el"
REL="7"
ARCH="x86_64"
TARBALL="puppet-enterprise-${PE_VERSION}-${DIST}-${REL}-${ARCH}.tar.gz"
INSTALLER_DIR="puppet-enterprise-${PE_VERSION}-${DIST}-${REL}-${ARCH}"
DOWNLOAD_URL="https://pm.puppet.com/cgi-bin/download.cgi?dist=${DIST}&rel=${REL}&arch=${ARCH}&ver=${PE_VERSION}"
CONSOLE_PASSWORD="<your_password_here>"

# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 
    exit 1
fi

# Download the installation tarball
echo "Downloading Puppet Enterprise ${PE_VERSION}..."
curl -JLO "${DOWNLOAD_URL}"

# Check if download was successful
if [[ ! -f "${TARBALL}" ]]; then
    echo "Download failed. Please check the URL or internet connection."
    exit 1
fi

# Unpack the tarball
echo "Extracting Puppet Enterprise..."
tar -xf "${TARBALL}"

# Run the PE installer
echo "Running the Puppet Enterprise installer..."
"./${INSTALLER_DIR}/puppet-enterprise-installer" <<EOF
Y
EOF

# Set the password for the PE console
echo "Setting Puppet Enterprise console password..."
puppet infrastructure console_password --password="${CONSOLE_PASSWORD}"

# Run Puppet agent twice
echo "Running Puppet agent for the first time..."
puppet agent -t

echo "Running Puppet agent for the second time..."
puppet agent -t

echo "Puppet Enterprise installation completed successfully!"
