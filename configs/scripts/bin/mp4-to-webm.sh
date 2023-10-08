#!/usr/bin/env bash

log() {
    echo "mp4-to-webm.sh : $1" 1>&2
}

log "converting ${1} to ${1%.mp4}.webm"

ffmpeg \
    -i "${1}" \
    -c:v libvpx-vp9 \
    -crf 30 \
    -b:v 0 \
    -b:a 128k \
    -c:a libopus \
    -hide_banner \
    -loglevel error \
    "${1%.mp4}.webm"
