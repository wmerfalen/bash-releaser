#!/bin/bash

if [[ $# -lt 5 ]]; then
	echo 'Usage: list-repo-artifacts.sh USER REPO PER_PAGE PAGE'
	exit 1
fi

GITHUB_USER=$(./bin/lib/sanitize-github-username.sh "$1")
GITHUB_REPO=$(./bin/lib/sanitize-github-reponame.sh "$2")
GITHUB_PER_PAGE=$(./bin/lib/intval.sh "$3")
GITHUB_PAGE=$(./bin/lib/intval.sh "$4")

echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_PER_PAGE: '${GITHUB_PER_PAGE}'"
echo "GITHUB_PAGE: '${GITHUB_PAGE}'"

if [[ ! -z "${GITHUB_DONT_SEND}" ]]; then
	echo '... GITHUB_DONT_SEND is set, so we will be exiting before the curl command happens'
	exit 0
fi


curl \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/actions/artifacts?per_page=${GITHUB_PER_PAGE}&page=${GITHUB_PAGE}
