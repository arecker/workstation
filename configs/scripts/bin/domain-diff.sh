#!/usr/bin/env bash

set -e

# Diff a domain between two different name servers.  Prompts for
# arguments interactely - just follow the instructions, stupid.

log() {
    echo "domain-diff.sh: $1" 1>&2
}

prompt() {
    local answer=""
    while [[ "${answer}" == "" ]]; do
        read answer
    done
    echo "$answer"
}

_dig() {
    local domain="$1"
    local ns="$2"
    dig +nottlid +noall +answer "@${ns}" "${domain}" ANY
}

if ! which diff &> /dev/null; then
    log "You don't have the diff command avaiable in your path!"
fi

log "What domain are you checking?"
echo -n "DOMAIN: "; DOMAIN="$(prompt)"

log "First nameserver?"
echo -n "NS1: "; NS1="$(prompt)"

log "Second nameserver?"
echo -n "NS2: "; NS2="$(prompt)"

log "diffing ${DOMAIN} between ${NS1} and ${NS2}"
if diff <(sort -u <(_dig "$DOMAIN" "$NS1")) <(sort -u <(_dig "$DOMAIN" "$NS2")); then
    log "no difference!"
fi
