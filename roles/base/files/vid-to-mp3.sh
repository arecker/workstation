#!/usr/bin/env bash
ffmpeg -i "$1" -f mp3 -ab 192000 -vn "$2"
