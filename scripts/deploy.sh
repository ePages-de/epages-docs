#!/bin/bash

REMOTE="git@github.com:choffmeister/jekyll-apidocs.git"

# change to project directory
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$DIR/../"

# clean and rebuild
rm -rf _site/
jekyll build

# force push site to gh-pages branch
cd _site
git init
git remote -v
git add .
git commit -m "Build"
git remote add origin "$REMOTE"
git push origin master:gh-pages --force

exit 0
