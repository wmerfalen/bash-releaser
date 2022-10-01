#!/bin/bash

if [[ $# -lt 5 ]]; then
	echo 'Usage: update-release-asset.sh USER REPO ASSET_ID NAME LABEL'
	exit 1
fi


GITHUB_USER=$(./bin/lib/sanitize-github-username.sh "$1")
GITHUB_REPO=$(./bin/lib/sanitize-github-reponame.sh "$2")
GITHUB_ASSET_ID=$(./bin/lib/intval.sh "$3")
GITHUB_ASSET_NAME="$4"
shift
shift
shift
shift
GITHUB_ASSET_LABEL="$*"

echo "GITHUB_ASSET_ID: '${GITHUB_ASSET_ID}'"
echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_ASSET_NAME: '${GITHUB_ASSET_NAME}'"
echo "GITHUB_ASSET_LABEL: '${GITHUB_ASSET_LABEL}'"

echo -e "Setting name to: '${GITHUB_ASSET_NAME}'"
echo -e "Setting label to: '${GITHUB_ASSET_LABEL}'"

JSON_STRING=$( jq -n -c \
		--arg name "$GITHUB_ASSET_NAME" \
		--arg gh_label "$GITHUB_ASSET_LABEL" \
		'{name: $name, label: $gh_label}')

echo -n "JSON_STRING: '${JSON_STRING}'"

if [[ ! -z "${GITHUB_DONT_SEND}" ]]; then
	echo '... GITHUB_DONT_SEND is set, so we will be exiting before the curl command happens'
	exit 0
fi


curl \
		-X PATCH \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
  	https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/assets/${GITHUB_ASSET_ID} \
		-d "${JSON_STRING}"
