#!/bin/bash

if [[ $# -lt 5 ]]; then
	echo 'Usage: upload-release-asset.sh USER REPO RELEASE_ID PATH_TO_ASSET NAME_OF_ASSET'
	exit 1
fi

GITHUB_USER=$(./bin/lib/sanitize-github-username.sh "$1")
GITHUB_REPO=$(./bin/lib/sanitize-github-reponame.sh "$2")
GITHUB_RELEASE_ID=$(./bin/lib/intval.sh "$3")
GITHUB_PATH_TO_ASSET="$4"
shift
shift
shift
shift
GITHUB_NAME_OF_ASSET="$(./bin/lib/urlencode.sh "$*")"

echo "GITHUB_RELEASE_ID: '${GITHUB_RELEASE_ID}'"
echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_PATH_TO_ASSET: '${GITHUB_PATH_TO_ASSET}'"
echo "GITHUB_NAME_OF_ASSET: '${GITHUB_NAME_OF_ASSET}'"

if [[ ! -z "${GITHUB_DONT_SEND}" ]]; then
	echo '... GITHUB_DONT_SEND is set, so we will be exiting before the curl command happens'
	exit 0
fi


curl \
		-X POST \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		-H "Content-Type: application/zip" \
		https://uploads.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/${GITHUB_RELEASE_ID}/assets?name="${GITHUB_NAME_OF_ASSET}" \
  	--data-binary "@${GITHUB_PATH_TO_ASSET}"
