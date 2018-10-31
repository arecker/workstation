#!/usr/bin/env bash

REPO_PATH="$HOME/src/notes/"
CUR_DIR="$(pwd)"

log() {
    echo "notes-sync.sh: $1"
}

cd "$REPO_PATH"

log "fetching"
git fetch --all --prune > /dev/null

log "comitting changes"
git add -A && git commit -m "notes-sync.sh: $(date)" > /dev/null

log "rebasing"
git rebase origin/master > /dev/null

log "pushing"
git push origin master > /dev/null

log "finished!"
cd "$CUR_DIR"
