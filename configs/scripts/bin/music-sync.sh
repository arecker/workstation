#!/usr/bin/env bash

log() {
    echo "music-sync.sh: $1" 1>&2
}

SRC="nas.local:/volume1/media/music/"
TRG="$HOME/Music/"

log "syncing $SRC to $TRG"
rsync -r --progress --size-only --exclude '*@eaDir*' "$SRC" "$TRG"
log "sync finished"
