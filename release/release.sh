#!/usr/bin/env bash
set -e

# -------- CONFIG --------
PROJECT_NAME="git-uncommit"
VERSION="$1"  # e.g., 1.0.0
if [ -z "$VERSION" ]; then
  echo "Usage: ./release.sh <version>"
  exit 1
fi
GITHUB_USER="below43"
REPO_URL="https://github.com/$GITHUB_USER/$PROJECT_NAME.git"
TARBALL_NAME="$PROJECT_NAME-$VERSION.tar.gz"
# ------------------------

# Step 1: Make sure git is clean
if ! git diff-index --quiet HEAD --; then
  echo "Git working tree is not clean. Commit or stash changes first."
  exit 1
fi

# Step 2: Update version tag
git tag -a "v$VERSION" -m "Release v$VERSION"

# Step 3: Create tarball from git tag
git archive --format=tar.gz -o "$TARBALL_NAME" "v$VERSION"

# Step 4: Generate SHA256
SHA256=$(shasum -a 256 "$TARBALL_NAME" | awk '{print $1}')
echo "SHA256: $SHA256"

# Step 5: Push tag to GitHub
git push origin "v$VERSION"

echo ""
echo "Release $VERSION ready."
echo "Upload $TARBALL_NAME to GitHub release page."
echo "Use SHA256 in Homebrew formula:"
echo "$SHA256"
