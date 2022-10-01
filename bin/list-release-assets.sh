#!/bin/bash

if [[ $# -lt 3 ]]; then
	echo 'Usage: list-release-assets.sh USER REPO RELEASE_ID'
	exit 1
fi

GITHUB_USER="$1"
GITHUB_REPO="$2"
GITHUB_RELEASE_ID="$3"

echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_RELEASE_ID: '${GITHUB_RELEASE_ID}'"

curl \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/${GITHUB_RELEASE_ID}/assets