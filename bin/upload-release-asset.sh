#!/bin/bash

if [[ $# -lt 5 ]]; then
	echo 'Usage: upload-release-asset.sh USER REPO RELEASE_ID PATH_TO_ASSET NAME_OF_ASSET'
	exit 1
fi

GITHUB_USER="$1"
GITHUB_REPO="$2"
GITHUB_RELEASE_ID="$3"
GITHUB_PATH_TO_ASSET="$4"
GITHUB_NAME_OF_ASSET="$5"

echo "GITHUB_RELEASE_ID: '${GITHUB_RELEASE_ID}'"
echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_PATH_TO_ASSET: '${GITHUB_PATH_TO_ASSET}'"
echo "GITHUB_NAME_OF_ASSET: '${GITHUB_NAME_OF_ASSET}'"

curl \
		-X POST \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		-H "Content-Type: application/zip" \
		--data-urlencode "name=${GITHUB_NAME_OF_ASSET}" \
  	https://uploads.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/${GITHUB_RELEASE_ID}/assets \
  	--data-binary "@${GITHUB_PATH_TO_ASSET}"
