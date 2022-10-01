#!/bin/bash

if [[ $# -lt 3 ]]; then
	echo 'Usage: delete-release-asset.sh USER REPO ASSET_ID'
	exit 1
fi

echo 'Please note, this endpoint doesnt appear to have a response body when an asset is successfully deleted'

GITHUB_USER="$1"
GITHUB_REPO="$2"
GITHUB_ASSET_ID="$3"

echo "GITHUB_ASSET_ID: '${GITHUB_ASSET_ID}'"
echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"

if [[ ! -z "${GITHUB_DONT_SEND}" ]]; then
	echo '... GITHUB_DONT_SEND is set, so we will be exiting before the curl command happens'
	exit 0
fi


curl \
		-X DELETE \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
  	https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/assets/${GITHUB_ASSET_ID}
