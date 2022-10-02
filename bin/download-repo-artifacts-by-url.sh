#!/bin/bash

if [[ $# -lt 3 ]]; then
	echo 'Usage: list-repo-artifacts.sh USER REPO ACTIONS_RUN_URL'
	exit 1
fi

GITHUB_USER=$(./bin/lib/sanitize-github-username.sh "$1")
GITHUB_REPO=$(./bin/lib/sanitize-github-reponame.sh "$2")
# Example run URL: https://github.com/wmerfalen/bls/actions/runs/3169651015
GITHUB_WORKFLOW_ID=$(echo "$3" | sed -E 's|actions/runs/|\n|' | tail -n 1 | tr -d '[:space:]')
GITHUB_WORKFLOW_ID=$(./bin/lib/intval.sh "${GITHUB_WORKFLOW_ID}")

echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_WORKFLOW_ID: '${GITHUB_WORKFLOW_ID}'"

if [[ ! -z "${GITHUB_DONT_SEND}" ]]; then
	echo '... GITHUB_DONT_SEND is set, so we will be exiting before the curl command happens'
	exit 0
fi


curl \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/actions/runs/${GITHUB_WORKFLOW_ID}/artifacts
