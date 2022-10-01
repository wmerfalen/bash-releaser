#!/bin/bash

GITHUB_USER_NAME="$1"

echo "${GITHUB_USER_NAME}" | sed -E 's|[^a-zA-Z0-9_\\.\\-]+||g'
