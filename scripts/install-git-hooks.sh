#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

git config core.hooksPath .githooks

printf '%s\n' "Configured Git hooks for $repo_root"
printf '%s\n' "core.hooksPath=.githooks"
