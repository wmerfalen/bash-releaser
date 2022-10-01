#!/bin/bash

if [[ $# -lt 2 ]]; then
	echo 'Usage: list.sh USER REPOSITORY'
	echo 'Example: list.sh dashhive bls'
	exit 1
fi

GITHUB_USER="$1"
GITHUB_REPO="$2"
curl \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases
