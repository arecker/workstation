#!/usr/bin/env bash
# pyenv-bootstrap.sh
set -e

PYTHON_VERSION="3.7.0"

log () {
  echo "pyenv-bootstrap.sh: $1"
}

if [ -d "$HOME/.pyenv" ]; then
  log "already bootstrapped, nothing to do."
  exit 1
fi

log "running installer"
curl -Ls "https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer" | PATH="$HOME/.pyenv/bin:$PATH" bash

log "initializing"
eval "$($HOME/.pyenv/bin/pyenv init -)"
eval "$($HOME/.pyenv/bin/pyenv virtualenv-init -)"

log "installing $PYTHON_VERSION"
$HOME/.pyenv/bin/pyenv install "$PYTHON_VERSION"

log "setting $PYTHON_VERSION as global"
$HOME/.pyenv/bin/pyenv global "$PYTHON_VERSION"

log "done!"
