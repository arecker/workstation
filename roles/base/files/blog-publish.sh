#!/usr/bin/env bash

set -e

DIR="$HOME/public/www.alexrecker.com"
BUCKET="blog-bucket-1edd2xs506ohe"

aws s3 sync --delete "$DIR/" "s3://$BUCKET/"
