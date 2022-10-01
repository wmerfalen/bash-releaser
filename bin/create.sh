#!/bin/bash

if [[ $# -lt 4 ]]; then
	echo 'Usage: create.sh USER REPO TAG_NAME NAME_OF_RELEASE'
	exit 1
fi

GITHUB_USER=$1
GITHUB_REPO=$2
GITHUB_TAG_NAME=$3
GITHUB_NAME=$4

echo "GITHUB_TAG_NAME: '${GITHUB_TAG_NAME}'"
echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_NAME: '${GITHUB_NAME}'"

exit 0
curl \
		-X POST \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases \
  	-d '{"tag_name":"'${GITHUB_TAG_NAME}'","target_commitish":"master","name":"'${GITHUB_NAME}'","body":"body","draft":false,"prerelease":false,"generate_release_notes":false}'
