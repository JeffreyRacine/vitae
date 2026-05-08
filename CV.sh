#!/opt/local/bin/bash

# Production crontab and workflow notes live in OPERATIONS.md. This script is
# intentionally clone-relative so it can run from the iCloud production checkout
# after that checkout pulls the accepted GitHub state.

set -euo pipefail

start_time=$(date +%s)
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
lock_dir="${CV_LOCK_DIR:-$script_dir/.cv-render.lock}"
push_after_commit="${CV_PUSH:-0}"

cleanup() {
  rm -rf "$lock_dir"
}
trap cleanup EXIT

if ! mkdir "$lock_dir" 2>/dev/null; then
  echo "Another CV render appears to be running: $lock_dir"
  exit 1
fi

echo "--- CV render started at $(date) ---"
echo "Repository: $script_dir"

if [ -f "$HOME/.bashrc" ]; then
  # shellcheck disable=SC1091
  source "$HOME/.bashrc"
fi

cd "$script_dir"

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if git rev-parse --abbrev-ref --symbolic-full-name '@{u}' >/dev/null 2>&1; then
    git pull --ff-only
  else
    echo "No upstream configured for current branch; skipping pull."
  fi
fi

rm -rf index_files
quarto render index.qmd
cp index.pdf vitae.pdf

git add \
  index.qmd cv.css numeric-ydnt.csl \
  publications-*.bib \
  r-logo.png r-logo.svg \
  index.html index_files index.pdf vitae.pdf \
  CV.sh makefile .gitignore _extensions

if git diff --cached --quiet; then
  echo "No CV changes to commit."
else
  commit_msg="Updated CV render: $(date +'%Y-%m-%d %H:%M:%S')"
  git commit -m "$commit_msg"
  if [ "$push_after_commit" = "1" ]; then
    git push
  else
    echo "CV_PUSH is not 1; leaving commit local."
  fi
fi

end_time=$(date +%s)
duration=$((end_time - start_time))
hours=$((duration / 3600))
minutes=$(((duration % 3600) / 60))
seconds=$((duration % 60))
echo "--- CV render finished at $(date) ---"
printf "Elapsed time: %02d:%02d:%02d\n" "$hours" "$minutes" "$seconds"
