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
cd "$SCRIPT_DIR/../app/static"

if [ -d "docs/" ] 
then
    echo "cleaning /docs/ subdirectory"
    rm -r "docs"/*
else
    echo "creating /docs/ subdirectory"
    mkdir "docs"
fi

echo "cloning generated documentation"
git clone -b $GH_PAGES_BRANCH --single-branch $GH_PAGES_REMOTE

echo "moving generated documentation into $SCRIPT_DIR/../app/static/docs"
mv "discovery/docs/html"/* "docs"

echo "cleaning up cloned repo"
rm -Rf "discovery"