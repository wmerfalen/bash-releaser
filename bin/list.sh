#!/bin/bash

if [[ $# -lt 2 ]]; then
	echo 'Usage: list.sh USER REPOSITORY'
	echo 'Example: list.sh dashhive bls'
	exit 1
fi

GITHUB_USER="$1"
GITHUB_REPO="$2"

if [[ ! -z "${GITHUB_DONT_SEND}" ]]; then
	echo '... GITHUB_DONT_SEND is set, so we will be exiting before the curl command happens'
	exit 0
fi

curl \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases
