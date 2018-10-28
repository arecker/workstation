#!/usr/bin/env bash
# rbenv-bootstrap.sh
set -e

RUBY_VERSION="2.5.1"

log () {
  echo "rbenv-bootstrap.sh: $1"
}

if [ -d "$HOME/.rbenv" ]; then
  log "already bootstrapped, nothing to do."
  exit 1
fi

log "running installer"
curl -Ls "https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer" | PATH="$HOME/.rbenv/bin:$PATH" bash

log "initializing"
eval "$($HOME/.rbenv/bin/rbenv init -)"

log "installing $RUBY_VERSION"
$HOME/.rbenv/bin/rbenv install "$RUBY_VERSION"

log "setting $RUBY_VERSION as global"
$HOME/.rbenv/bin/rbenv global "$RUBY_VERSION"

log "done!"
