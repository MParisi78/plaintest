#!/usr/bin/env bash
# push_to_github.sh
# Run this from inside the unzipped "plaintest" folder to push everything
# to your empty GitHub repo in one shot.
#
# Prereqs: git installed, and you're signed in to GitHub (it'll prompt for
# credentials / a personal access token on push if needed).
#
# Usage:  bash push_to_github.sh

set -e

REPO_URL="https://github.com/MParisi78/plaintest.git"

echo "Initializing git repo..."
git init
git add .
git commit -m "Add daily plane finder: script, workflow, README"
git branch -M main
git remote add origin "$REPO_URL"

echo "Pushing to $REPO_URL ..."
git push -u origin main

echo ""
echo "Done. Next steps:"
echo "  1. On GitHub: Settings -> Secrets and variables -> Actions -> add the 5 PF_* secrets"
echo "  2. Actions tab -> Daily Plane Finder -> Run workflow (to test)"
