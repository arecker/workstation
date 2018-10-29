#!/usr/bin/env bash
# sbcl-bootstrap.sh
set -e

log() {
    echo "sbcl-bootstrap.sh: $1"
}

if [ -d "$HOME/.quicklisp" ]; then
    log "already bootstrapped, nothing to do."
    exit 1
fi

log "downloading quicklisp library"
curl -sO /tmp/quicklisp.lisp https://beta.quicklisp.org/quicklisp.lisp

log "running quicklisp installer"
sbcl --load /tmp/quicklisp.lisp --eval '(quicklisp-quickstart:install :path "~/.quicklisp/")'

log "finished!"
