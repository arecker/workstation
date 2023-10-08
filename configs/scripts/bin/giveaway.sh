#!/usr/bin/env bash

cd ~/src/shillgram/ || exit 1

run() {
    pipenv run python shillgram.py contest \
	   --username "alex_recker" \
	   --password "$(pass instagram)" \
	   --no-tagging \
	   --url "$1"
}

run "$1"
