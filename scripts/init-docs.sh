#!/usr/bin/env bash
# Prepare documentation

set -e

GH_PAGES_BRANCH="gh-pages"
GH_PAGES_REMOTE="git@github.com:PSHCDevOps/discovery.git"

SCRIPT_DIR="$(cd "$(dirname "$([ `readlink "$0"` ] && echo "`readlink "$0"`" || echo "$0")")"; pwd -P)"
cd "$SCRIPT_DIR/../app/static"

mkdir "docs"

git clone -b $GH_PAGES_BRANCH --single-branch GH_PAGES_REMOTE

mv "discovery/docs/html"/* "docs"

rm -Rf "discovery"