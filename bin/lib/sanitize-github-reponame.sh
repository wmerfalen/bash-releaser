#!/bin/bash

GITHUB_REPOSITORY_NAME="$1"

echo "${GITHUB_REPOSITORY_NAME}" | sed -E 's|[^a-zA-Z0-9_\\.\\-]+||g'
