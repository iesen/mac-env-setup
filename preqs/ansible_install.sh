#!/bin/bash
###
# Installs or updates Ansible via pip
###
"`dirname $0`"/./python3_check.sh
version_check=$?
echo "Ansible version check result: $version_check"
if [[ $version_check -ne 0 ]]; then
    if ! command -v pip &> /dev/null; then
        echo "Please install python3 first." 1>&2
        exit 1
    fi
    echo "Installing ansible..." 
    pip install ansible
fi
