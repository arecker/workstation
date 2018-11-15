#!/usr/bin/env bash

REPO_PATH="$HOME/docs/"
CUR_DIR="$(pwd)"

log() {
    echo "docs-sync.sh: $1"
}

cd "$REPO_PATH"

log "fetching"
git fetch --all --prune --quiet

log "comitting changes"
git add -A && git commit -m "docs-sync.sh: $(date)" > /dev/null

log "rebasing"
git rebase -Xours origin/master > /dev/null

log "pushing"
git push origin master --quiet > /dev/null

log "finished!"
cd "$CUR_DIR"
