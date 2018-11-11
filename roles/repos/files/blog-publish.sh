#!/usr/bin/env bash

set -e

SITE_DIR="/home/alex/public/www.alexrecker.com"
REGION_NAME="us-east-2"
STACK_NAME="blog"

bucket_name() {
    aws cloudformation \
	describe-stacks --stack-name "$STACK_NAME" --region "$REGION_NAME" \
	| jq -r '.Stacks[0].Outputs[]| select(.OutputKey == "Bucket").OutputValue'
}

aws s3 sync --delete "$SITE_DIR" "s3://$(bucket_name)"

