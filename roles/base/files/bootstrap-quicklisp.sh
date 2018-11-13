#!/usr/bin/env bash
# bootstrap-quicklisp.sh
set -e

log() {
    echo "bootstrap-quicklisp.sh: $1"
}

log "downloading quicklisp library"
curl -s -o /tmp/quicklisp.lisp https://beta.quicklisp.org/quicklisp.lisp

log "running quicklisp installer"
sbcl --load /tmp/quicklisp.lisp --eval '(quicklisp-quickstart:install :path "~/.quicklisp/")'

log "finished!"
