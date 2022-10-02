#!/bin/bash

if [[ $# -lt 2 ]]; then
	echo 'Usage: list-repo-artifacts.sh USER REPO'
	exit 1
fi

GITHUB_USER=$(./bin/lib/sanitize-github-username.sh "$1")
GITHUB_REPO=$(./bin/lib/sanitize-github-reponame.sh "$2")

echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"

if [[ ! -z "${GITHUB_DONT_SEND}" ]]; then
	echo '... GITHUB_DONT_SEND is set, so we will be exiting before the curl command happens'
	exit 0
fi


curl \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/actions/artifacts
