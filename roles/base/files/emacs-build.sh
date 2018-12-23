#!/usr/bin/env bash
set -e

EMACS_SRC="$HOME/src/emacs"
CUR_DIR="$(pwd)"

log() {
    echo "emacs-build.sh: $1"
}

build() {
    cd "$EMACS_SRC"
    log "cleaning git"
    git clean -dxf
    git fetch origin
    log "checking out $1"
    git checkout "$1"
    log "building $1"
    ./autogen.sh
    ./configure --prefix="$HOME/.local/" \
		--bindir=$HOME/bin \
		--with-x-toolkit \
		--with-xft
    make bootstrap
    log "installing $1"
    make install
}

if [ -z "$1" ]; then
    log "Usage: emacs-build.sh {tag}"
    exit 1
else
    build "$1"
    log "done!"
    cd "$CUR_DIR"
fi
