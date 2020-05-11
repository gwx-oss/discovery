#!/usr/bin/env bash
# Prepare documentation

set -e

#-------------------------------------------------------------------------------
GH_PAGES_BRANCH="gh-pages"
GH_PAGES_REMOTE="git@github.com:PSHCDevOps/discovery.git"
SCRIPT_DIR="$(cd "$(dirname "$([ `readlink "$0"` ] && echo "`readlink "$0"`" || echo "$0")")"; pwd -P)"
#-------------------------------------------------------------------------------

echo "navigating to $SCRIPT_DIR/../app/static"
cd "$SCRIPT_DIR/../app/static"

echo "creating /docs/ directory"
mkdir "docs"

echo "cloning generated documentation"
git clone -b $GH_PAGES_BRANCH --single-branch GH_PAGES_REMOTE

echo "moving generated documentation into $SCRIPT_DIR/../app/static/docs"
mv "discovery/docs/html"/* "docs"

echo "cleaning up cloned repo"
rm -Rf "discovery"