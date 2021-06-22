#!/bin/bash
###
# Installs or updates python3 via pyenv
###
TEAM_DEP_VERSION_PYTHON3="3.9.4"
"`dirname $0`"/./python3_check.sh
version_check=$?
echo "Python version check result: $version_check"
if [[ $version_check -ne 0 ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Please install homebrew first." 1>&2    
        exit 1
    fi
    pyenv_version=$(brew list --versions | grep pyenv | cut -d " " -f 2)
    if [[ $pyenv_version == '' ]]; then
        echo "Installing pyenv..."
        brew install pyenv  
    fi
    global_python=$(pyenv global)
    if [[ $global_python == 'system' ]]; then
        echo "Installing python 3..."
        pyenv install $TEAM_DEP_VERSION_PYTHON3
	    pyenv global $TEAM_DEP_VERSION_PYTHON3
        echo -e '# Init pyenv\nif command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
    fi  
fi
