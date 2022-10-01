#!/bin/bash

if [[ $# -lt 4 ]]; then
	echo 'Usage: create.sh USER REPO TAG_NAME NAME_OF_RELEASE'
	exit 1
fi

GITHUB_USER="$1"
GITHUB_REPO="$2"
GITHUB_TAG_NAME="$3"
shift
shift
shift
GITHUB_NAME="$*"

echo "GITHUB_TAG_NAME: '${GITHUB_TAG_NAME}'"
echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_NAME: '${GITHUB_NAME}'"

JSON_STRING=$( jq -n -c \
	--arg github_tag_name "${GITHUB_TAG_NAME}" \
	--arg github_name "${GITHUB_NAME}" \
	'{tag_name: $github_tag_name, name: $github_name, body: "body", draft: false, prerelease: false,generate_release_notes: false}' )

echo "JSON_STRING: '$JSON_STRING'"

curl \
		-X POST \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases \
  	-d "${JSON_STRING}"
