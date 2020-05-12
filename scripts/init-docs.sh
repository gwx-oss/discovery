#!/usr/bin/env bash
# Prepare documentation

set -e

#-------------------------------------------------------------------------------
GH_PAGES_BRANCH="gh-pages"
GH_PAGES_REMOTE="https://github.com/PSHCDevOps/discovery.git"
#Testing locally directory
#SCRIPT_DIR=./
#Cloud directory
SCRIPT_DIR="$(cd "$(dirname "$([ `readlink "$0"` ] && echo "`readlink "$0"`" || echo "$0")")"; pwd -P)"
#-------------------------------------------------------------------------------

echo "navigating to $SCRIPT_DIR/../app/static"

# Testing with /docs2/
if [ -d "docs2/" ] 
then
    echo "cleaning /docs2/ subdirectory"
    rm -r "docs2"/*
else
    echo "creating /docs2/ subdirectory"
    mkdir "docs2"
fi

echo "cloning generated documentation"
git clone -b $GH_PAGES_BRANCH --single-branch $GH_PAGES_REMOTE

echo "moving generated documentation into $SCRIPT_DIR/../app/static/docs2"
mv "discovery/docs/html"/* "docs2"

echo "cleaning up cloned repo"
rm -Rf "discovery"