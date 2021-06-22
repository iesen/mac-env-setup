#/bin/bash
###
# Check homebrew
###
TEAM_DEP_VERSION_HOMEBREW="3.1.8"
if ! command -v brew &> /dev/null ; then
    exit 1
fi
current_version=$(brew -v | head -n1 | cut -d' ' -f2)
result=$("`dirname $0`"/utils/semver.sh compare "$TEAM_DEP_VERSION_HOMEBREW" $current_version)
exit $result
