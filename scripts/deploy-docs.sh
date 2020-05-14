#!/usr/bin/env bash
# Update the GitHub pages documentation site
#
#
# >> This script must be run within a Python virtualized environment
#
set -e

SCRIPT_USAGE="
 Usage: <project-dir>/scripts/update-docs.sh [ -h ] [ <source-branch> ]

   -r | --remote   |  Git remote to push documentation updates to (default: git@github.com:PSHCDevOps/discovery.git)
   -m | --message  |  Override the documentation update commit message
   -h | --help     |  Display this help message
"

SCRIPT_DIR="$(cd "$(dirname "$([ `readlink "$0"` ] && echo "`readlink "$0"`" || echo "$0")")"; pwd -P)"
cd "$SCRIPT_DIR/.."

#-------------------------------------------------------------------------------
# Defaults

DEFAULT_SOURCE_BRANCH="`git branch | grep '*' | sed -r -e 's/^\*[[:space:]]+//'`"
GH_PAGES_BRANCH="gh-pages"
GH_PAGES_REMOTE="git@github.com:PSHCDevOps/discovery.git"

DOC_UPDATE_MESSAGE="Building and publishing documentation updates"

BUILD_DIR="/tmp/gh-pages"
SITE_TEMP_DIR="/tmp/discovery-html-docs"

#-------------------------------------------------------------------------------
# Option / Argument parsing

SCRIPT_ARGS=()

while [[ $# > 0 ]]
do
  key="$1"

  case $key in
    -h|--help)
      echo "$SCRIPT_USAGE"
      exit 0
    ;;
    -r|--remote)
      GH_PAGES_REMOTE="$2"
      shift
    ;;
    -u|--update)
      DOC_UPDATE_MESSAGE="$2"
      shift
    ;;
    *)
      # argument
      SCRIPT_ARGS+=("$key")
    ;;
  esac
  shift
done

SOURCE_BRANCH="${SCRIPT_ARGS[0]}"

if [ -z "$SOURCE_BRANCH" ]
then
  SOURCE_BRANCH="$DEFAULT_SOURCE_BRANCH"
fi

#-------------------------------------------------------------------------------
# Execution

# IMPORTANT: This script should be NON-destructive of the current repository
# in case there is unstaged work or untracked files we don't want to wipe
# accidentally!!!!  This means we need to pull a fresh version to work with.

if which git >/dev/null && which make >/dev/null
then
    # Ensure a clean build
    echo "cleaning $BUILD_DIR"
    rm -Rf "$BUILD_DIR"
    echo "cleaing $SITE_TEMP_DIR"
    rm -Rf "$SITE_TEMP_DIR"

    # Fetch source repository
    echo "cloning $SOURCH_BRANCH $GH_PAGES_REMOTE into $BUILD_DIR"
    git clone -b "$SOURCE_BRANCH" "$GH_PAGES_REMOTE" "$BUILD_DIR"
    cd "$BUILD_DIR"/docs
    pwd 

    # Build and preserve documentation
    echo "generating html"
    make html

    # Edit generated files so external links open in new tab
    # Edit index pages so it can be copied over to Django app doc template during initialization
    echo "editing generated index html for Django app coherence"
    sed -i 's/class="reference internal" href="architecture/class="reference internal" href="docs\/architecture/g' "build/html/index.html"
    sed -i 's/class="reference internal" href="start/class="reference internal" href="docs\/start/g' "build/html/index.html"
    sed -i 's/class="reference internal" href="process/class="reference internal" href="docs\/process/g' "build/html/index.html"

    echo "editing generated html to open external links in new tabs"
    HTML_FILES="build/html"/*
    echo "editing collection $HTML_FILES"
    for file in $HTML_FILES
    do 
      if [ -d $file ]
      then
        for inner_file in $file/*
          do
            if [ -d $inner_file ]
            then
              echo "$inner_file is directory"
              for inner_inner_file in $inner_file/*
              do
                if [[ $inner_inner_file =~ \.html$ ]]
                then
                  echo "editing $inner_inner_file"
                  sed -i 's/class="reference external"/class="reference external" target="_blank" rel="noopener noreferrer"/g' $inner_inner_file
                fi
              done
            else
              if [[ $inner_file =~ \.html$ ]]
              then
                echo "editing $inner_file"
                sed -i 's/class="reference external"/class="reference external" target="_blank" rel="noopener noreferrer"/g' $inner_file
              fi
            fi
          done
      else  
        if [[ $file =~ \.html$ ]]
        then
          echo "editing $file"
          sed -i 's/class="reference external"/class="reference external" target="_blank" rel="noopener noreferrer"/g' $file
        fi
      fi 
    done  

    echo "making $SITE_TEMP_DIR/docs"
    mkdir -p $SITE_TEMP_DIR/docs

    echo "moving build/html into $SITE_TEMP_DIR/docs"
    mv build/html "$SITE_TEMP_DIR"/docs
    
    # Replace all files with generated documentation site
    cd "$BUILD_DIR"
    pwd

    echo "checking out $GH_PAGES_BRANCH"
    git checkout "$GH_PAGES_BRANCH"

    echo "cleaning git branch $GH_PAGES_BRANCH"
    rm -Rf *
    
    echo "moving $SITE_TEMP_DIR into $BUILD_DIR"
    mv $SITE_TEMP_DIR/* "$BUILD_DIR"

    # Disable GitHub Jekyll
    touch .nojekyll
    
    # Update Git repository and publish site updates
    echo "Adding files"
    git add -A
    git diff-index --quiet HEAD || git commit -m "$DOC_UPDATE_MESSAGE"
    
    echo "Pushing files"
    git push origin "$GH_PAGES_BRANCH"
    
    # Clean up after ourselves
    echo "cleaning $SITE_TEMP_DIR"
    rm -Rf "$SITE_TEMP_DIR"

    echo "cleaning $BUILD_DIR"
    rm -Rf "$BUILD_DIR"

else
    echo "The update-docs script requires git and make to be installed"
    exit 1  
fi
