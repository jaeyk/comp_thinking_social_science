#!/bin/sh

set -e

# [ -z "${GITHUB_PAT}" ] && exit 0
# [ "${TRAVIS_BRANCH}" != "master" ] && exit 0

# git config --global user.email "jaeyk@github.com"
# git config --global user.name "Jae Yeon Kim"

# git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git book-output

cd docs

# cp -r ../_book/* ./

git add --all *

git commit -m "Update the book" || true

git pull

git push -u origin main
