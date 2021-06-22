#!/bin/bash
###
# Installs or updates homebrew
###
if ! command -v brew &> /dev/null; then
    # Get sudo password
    echo "Please enter your password for admin rights:"
    read -s pass
    # Download homebrew install script
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > ./install.sh
    chmod +x ./install.sh
    # Store admin password in keychain
    security add-generic-password -a ${USER} -s ty-envsetup-sudo -w $pass -U
    # Configure askpass script file
    echo -e "#!/bin/bash\nsecurity find-generic-password -s ty-envsetup-sudo -a ${USER} -w\n" > pass.sh
    chmod +x ./pass.sh
    export SUDO_ASKPASS="`pwd dirname $0`"/./pass.sh
    # Start install script
    CI=1 "`dirname $0`"/./install.sh
    brew analytics off
    # Clean up environment
    rm pass.sh install.sh
    export SUDO_ASKPASS=""
    exit 0
fi
# update if necessary
"`dirname $0`"/./brew_check.sh
version_check=$?
echo "Homebrew version check result: $version_check"
if [[ $version_check -ne 0 ]]; then
    echo "Updating homebrew..."
    brew update
    brew analytics off
fi
