#/bin/bash
###
# Check homebrew
###
TEAM_DEP_VERSION_ANSIBLE="4.0.0"
if ! command -v ansible &> /dev/null ; then
    exit 1
fi
current_version=$(pip show ansible | grep "Version" | cut -d' ' -f2)
result=$("`dirname $0`"/utils/semver.sh compare "$TEAM_DEP_VERSION_ANSIBLE" $current_version)
exit $result
