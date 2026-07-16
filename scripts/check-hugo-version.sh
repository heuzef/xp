#!/bin/bash
# Watch the Ubuntu apt repository for a Hugo package version that satisfies
# the minimum version required by the Hugo-Narrow theme.
#
# Prints a message (and exits 0) only when a satisfying version is available,
# so it stays silent otherwise. Meant to be run from cron: cron only mails
# its output when there is some, which makes this a low-noise notifier.
#
# Usage: ./check-hugo-version.sh [required-version]
set -euo pipefail

REQUIRED_VERSION="${1:-0.158.0}"

CANDIDATE_RAW=$(apt-cache policy hugo 2>/dev/null | awk '/Candidate:/{print $2}')

if [ -z "$CANDIDATE_RAW" ]; then
    echo "Unable to read the hugo candidate version (is hugo known to apt? try 'sudo apt-get update' first)" >&2
    exit 2
fi

CANDIDATE_VERSION=$(echo "$CANDIDATE_RAW" | sed -E 's/^([0-9]+\.[0-9]+\.[0-9]+).*/\1/')

if dpkg --compare-versions "$CANDIDATE_VERSION" ge "$REQUIRED_VERSION"; then
    echo "Hugo $CANDIDATE_VERSION is now available in the Ubuntu apt repository (>= required $REQUIRED_VERSION)."
    echo "Upgrade with: sudo apt install --only-upgrade hugo"
    exit 0
fi

exit 1
