#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install necessary system packages
sudo apt update
sudo apt install -y python3-venv git python3-dev libffi-dev gcc libssl-dev sshpass

# Set up a Python virtual environment
python3 -m venv /root/venv
source /root/venv/bin/activate

# Upgrade pip
pip install -U pip

# Install ansible-core
pip install 'ansible-core>=2.16,<2.17.99'

# Install kolla-ansible
pip install git+https://opendev.org/openstack/kolla-ansible@stable/2024.1

# Install OpenStack client libraries
pip install python-octaviaclient
pip install python-swiftclient

# Prepare Kolla configuration directory
sudo mkdir -p /etc/kolla
sudo chown $USER:$USER /etc/kolla

# Copy configuration files
cp -r /root/venv/share/kolla-ansible/etc_examples/kolla/* /etc/kolla
cp /root/venv/share/kolla-ansible/ansible/inventory/multinode /etc/kolla/

# Verify copied files
ls /etc/kolla/

# Install kolla dependencies
kolla-ansible install-deps

# Generate Kolla passwords
kolla-genpwd

# Install the OpenStack client
pip install python-openstackclient -c https://releases.openstack.org/constraints/upper/2024.1
