#!/usr/bin/env bash

read_aws_secret() {
    PASSWORD_STORE_DIR="$HOME/.password-store/" pass "reckerops/aws-${1}" | tail -1
}

KEY_ID="$(read_aws_secret access-key-id)"
KEY_SECRET="$(read_aws_secret secret-access-key)"

eval "AWS_ACCESS_KEY_ID=$KEY_ID AWS_SECRET_ACCESS_KEY=$KEY_SECRET $@"
