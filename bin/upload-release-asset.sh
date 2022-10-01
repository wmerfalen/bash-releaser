#!/bin/bash

if [[ $# -lt 4 ]]; then
	echo 'Usage: create.sh USER REPO RELEASE_ID PATH_TO_ASSET'
	exit 1
fi

GITHUB_USER="$1"
GITHUB_REPO="$2"
GITHUB_RELEASE_ID="$3"
GITHUB_PATH_TO_ASSET="$4"

echo "GITHUB_RELEASE_ID: '${GITHUB_RELEASE_ID}'"
echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_PATH_TO_ASSET: '${GITHUB_PATH_TO_ASSET}'"

curl \
		-X POST \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
  	https://uploads.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/${GITHUB_RELEASE_ID}/assets \
  	--data-binary "@${GITHUB_PATH_TO_ASSET}"
