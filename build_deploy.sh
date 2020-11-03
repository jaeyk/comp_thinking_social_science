#!/bin/sh

# Build
./_build.sh

# Deploy
./_deploy.sh

# Add
git add .

# Commit changes.
printf "\033[0;32mCommitting.\033[0m\n"
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
        msg="$*"
fi

git commit -m "$msg"

git push
