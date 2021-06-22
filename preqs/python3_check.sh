#/bin/bash
###
# Check homebrew
###
TEAM_DEP_VERSION_PYTHON="3.0.0"
if ! command -v python &> /dev/null ; then
    exit 1
fi
current_version=$(python --version 2>&1 | head -n1 | cut -d' ' -f2)
result=$("`dirname $0`"/utils/semver.sh compare "$TEAM_DEP_VERSION_PYTHON" $current_version)
exit $result
