#!/bin/bash
# Two-way sync between public/ (Dropbox, what Firebase serves) and the private
# SEA repo github.com/sites-9400/sea-2026, where Alysson edits.
#
#   _reference/sync-sea.sh            sync only (the midnight ICI job deploys)
#   _reference/sync-sea.sh --deploy   sync, then firebase deploy --only hosting
#
# Order: local edits are committed in the clone first, then GitHub is merged in,
# so a clash shows up as a git conflict instead of one side silently winning.
# On a conflict nothing in public/ is touched. Deletions are not synced.
set -euo pipefail

REPO="$HOME/sea-2026"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SITE="$ROOT/public"
ASSETS=(site.css sea.css theme.js)

# Push/fetch as the travel account, never the ICI one that is gh's default.
git_gh() {
  git -c credential.helper= \
      -c credential.helper='!f(){ echo username=sites-9400; echo "password=$(gh auth token -u sites-9400)"; }; f' "$@"
}

cd "$REPO"
if [ -n "$(git status --porcelain)" ] || [ -f .git/MERGE_HEAD ]; then
  echo "STOP: $REPO has uncommitted changes or an unfinished merge. Resolve it first." >&2
  exit 1
fi
git_gh fetch -q origin

# 1. Dropbox -> clone, committed as our side.
rsync -a --include='*.html' --exclude='*' "$SITE/2026-12-sea/" "$REPO/2026-12-sea/"
for a in "${ASSETS[@]}"; do cp "$SITE/assets/$a" "$REPO/assets/$a"; done
if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -qm "Sync from Dropbox"
  echo "Local edits committed:"; git show --stat --format= HEAD | sed 's/^/  /'
fi

# 2. Merge GitHub (Alysson's pushes).
BEFORE=$(git rev-parse HEAD)
if ! git merge -q --no-edit origin/main; then
  echo "STOP: conflict between local edits and GitHub. public/ untouched." >&2
  git diff --name-only --diff-filter=U | sed 's/^/  conflict: /' >&2
  exit 1
fi
INCOMING=$(git diff --name-only "$BEFORE" HEAD)
if [ -n "$INCOMING" ]; then
  echo "From GitHub:"; echo "$INCOMING" | sed 's/^/  /'
  git log --format='  %h %an: %s' "$BEFORE..HEAD" --no-merges
  if echo "$INCOMING" | grep -q 'assets/site.css'; then
    echo "WARNING: site.css changed. It also styles Siargao and the landing page. Check them." >&2
  fi
fi
git_gh push -q origin main

# 3. Clone -> Dropbox.
rsync -a --include='*.html' --exclude='*' "$REPO/2026-12-sea/" "$SITE/2026-12-sea/"
for a in "${ASSETS[@]}"; do cp "$REPO/assets/$a" "$SITE/assets/$a"; done
echo "In sync at $(git rev-parse --short HEAD)."

if [ "${1:-}" = "--deploy" ]; then
  cd "$ROOT" && firebase deploy --only hosting
fi
