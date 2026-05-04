#!/bin/bash
# ============================================================
# Trinity Healing Temple CMS — GitHub Push Script (macOS)
# Run this from Terminal: bash push_to_github.sh
# ============================================================

set -e   # Stop on any error

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   Trinity Healing Temple CMS — GitHub Push       ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# ── CONFIG — edit these before first run ─────────────────
GITHUB_USERNAME="YOUR_GITHUB_USERNAME"   # ← change this
REPO_NAME="trinity-healing-temple-cms"
BRANCH="main"
# ─────────────────────────────────────────────────────────

# Check git is installed
if ! command -v git &>/dev/null; then
  echo "❌  Git not found. Install Xcode Command Line Tools:"
  echo "    xcode-select --install"
  exit 1
fi

echo "✅  Git found: $(git --version)"

# ── If this is the FIRST push (no .git folder) ───────────
if [ ! -d ".git" ]; then
  echo ""
  echo "📁  Initializing new Git repository..."
  git init
  git branch -M "$BRANCH"

  echo "🔗  Connecting to GitHub..."
  git remote add origin "https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"

  echo "📦  Staging all files..."
  git add .

  echo "💾  Creating initial commit..."
  git commit -m "🎉 Initial commit — Trinity Healing Temple CMS v2.0

  ✝ Trinity Healing Temple of Jesus Church, Inc.
  📍 Topoe Community, Lower New Georgia, Monrovia, Liberia

  Features:
  - 265 members loaded from THT membership register
  - 107 members auto-assigned to Youth Dept (age < 35)
  - Weekly birthday SMS tracker for all 8 departments
  - Role-based portal access: Super Admin, Dept Leaders
  - 10 portal login accounts pre-configured
  - Complete PHP/MySQL backend (50+ API endpoints)
  - Full member management with search & export

  Built by George Q. Gaylah — Dynamic Technology, Monrovia, Liberia"

  echo ""
  echo "🚀  Pushing to GitHub..."
  echo "    (When prompted for password, paste your GitHub Personal Access Token)"
  echo ""
  git push -u origin "$BRANCH"

# ── For SUBSEQUENT pushes ─────────────────────────────────
else
  echo ""
  echo "📝  What changed? (describe your update briefly)"
  echo "    Press ENTER to use default message"
  read -r commit_msg

  if [ -z "$commit_msg" ]; then
    commit_msg="Update Trinity CMS — $(date '+%B %d, %Y at %H:%M')"
  fi

  echo ""
  echo "📦  Staging changes..."
  git add .

  # Check if there's anything to commit
  if git diff --staged --quiet; then
    echo "ℹ️   No changes to commit."
    exit 0
  fi

  echo "💾  Committing..."
  git commit -m "$commit_msg"

  echo "🚀  Pushing to GitHub..."
  git push origin "$BRANCH"
fi

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   ✅  Done! Successfully pushed to GitHub        ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "🔗  View your repo:"
echo "    https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
echo ""
echo "🌐  GitHub Pages (after enabling in Settings):"
echo "    https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
echo ""
