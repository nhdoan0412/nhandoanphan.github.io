#!/usr/bin/env bash
set -euo pipefail

OWNER="nhdoan0412"
OLD_REPO="Project"
NEW_REPO="ai-resume-parser"
PROFILE_REPO="nhdoan0412"

echo "== Nhan Doan GitHub recruiting-profile setup =="

if ! command -v gh >/dev/null 2>&1; then
  echo
  echo "GitHub CLI (gh) is not installed."
  echo "On macOS with Homebrew, run:"
  echo "  brew install gh"
  exit 1
fi

echo
echo "Checking GitHub authentication..."
if ! gh auth status >/dev/null 2>&1; then
  echo "You are not logged into GitHub CLI."
  echo "Run: gh auth login"
  exit 1
fi

echo
echo "1) Checking AI Resume Parser repository name..."
if gh repo view "$OWNER/$NEW_REPO" >/dev/null 2>&1; then
  echo "   Already renamed: $OWNER/$NEW_REPO"
elif gh repo view "$OWNER/$OLD_REPO" >/dev/null 2>&1; then
  echo "   Renaming $OWNER/$OLD_REPO -> $OWNER/$NEW_REPO"
  gh repo rename -R "$OWNER/$OLD_REPO" "$NEW_REPO" --yes
  echo "   Rename complete."
else
  echo "   Could not find either $OWNER/$OLD_REPO or $OWNER/$NEW_REPO."
  exit 1
fi

echo
echo "2) Checking special GitHub profile repository..."
if gh repo view "$OWNER/$PROFILE_REPO" >/dev/null 2>&1; then
  echo "   Profile repository already exists: $OWNER/$PROFILE_REPO"
else
  echo "   Creating public profile repository: $OWNER/$PROFILE_REPO"
  gh repo create "$OWNER/$PROFILE_REPO" \
    --public \
    --add-readme \
    --description "GitHub profile README for Nhan Doan"
  echo "   Profile repository created."
fi

echo
echo "Done with the terminal-only steps."
echo
echo "Next:"
echo "  1. Return to ChatGPT and say: GitHub terminal steps done"
echo "  2. ChatGPT can then copy the prepared PROFILE_README.md into the new profile repo"
echo "     and update links from Project to ai-resume-parser."
echo "  3. Finally, customize your six pinned repositories in the GitHub profile UI."
echo
echo "Profile: https://github.com/$OWNER"
