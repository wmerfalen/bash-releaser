#!/bin/bash

if [[ $# -lt 4 ]]; then
	echo 'Usage: download-repo-artifacts-by-url.sh USER REPO ACTIONS_RUN_URL DESTINATION_FOLDER'
	exit 1
fi

GITHUB_USER=$(./bin/lib/sanitize-github-username.sh "$1")
GITHUB_REPO=$(./bin/lib/sanitize-github-reponame.sh "$2")
# Example run URL: https://github.com/wmerfalen/bls/actions/runs/3169651015
GITHUB_WORKFLOW_ID=$(echo "$3" | sed -E 's|actions/runs/|\n|' | tail -n 1 | tr -d '[:space:]')
GITHUB_WORKFLOW_ID=$(./bin/lib/intval.sh "${GITHUB_WORKFLOW_ID}")
GITHUB_DESTINATION_FOLDER="$4"

echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_WORKFLOW_ID: '${GITHUB_WORKFLOW_ID}'"
echo "GITHUB_DESTINATION_FOLDER: '${GITHUB_DESTINATION_FOLDER}'"

if [[ ! -z "${GITHUB_DONT_SEND}" ]]; then
	echo '... GITHUB_DONT_SEND is set, so we will be exiting before the curl command happens'
	exit 0
fi

TMP_DIR=$PWD/.tmp

if [[ ! -d "$TMP_DIR" ]]; then
	mkdir -p "$TMP_DIR"
fi

if [[ ! -d "${GITHUB_DESTINATION_FOLDER}" ]]; then
	echo "Creating destination folder '${GITHUB_DESTINATION_FOLDER}'"
	mkdir -p "${GITHUB_DESTINATION_FOLDER}"
fi


TMP_FILE="${TMP_DIR}/artifacts-${GITHUB_WORKFLOW_ID}.json"

curl \
		-H "Accept: application/vnd.github+json" \
		-H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/actions/runs/${GITHUB_WORKFLOW_ID}/artifacts > "${TMP_FILE}"

ARTIFACT_RESPONSES="${TMP_DIR}/artifact-responses-${GITHUB_WORKFLOW_ID}"

DICTIONARY_FILE="${TMP_DIR}/artifact-dictionary-${GITHUB_WORKFLOW_ID}"

cat "${TMP_FILE}" |
	grep -E '    {' -A 3 |
	grep -vE '^\s+"node_id"' |
	grep -v '    {' |
	tr -d '\n' |
	tr -d '[:space:]' |
	sed -E 's|"id":||g' |
	sed -E 's|"name":||g' |
	sed -E 's|\-\-|\n|g' |
	sed -E 's|,$||' > "${DICTIONARY_FILE}"

for ARTIFACT_ID in $(cat "${TMP_FILE}" | grep -E '   {' -A 3 | grep -E '"id": [0-9]+,' | cut -d':' -f 2 | tr -d ',' | sed -E 's|^ ||'); do
	FILE_NAME=$(cat "${DICTIONARY_FILE}" | grep -E "^${ARTIFACT_ID}\\,\"" | cut -d ',' -f 2 | cut -d'"' -f 2)
	FILE_NAME="${GITHUB_DESTINATION_FOLDER}/${FILE_NAME}.zip"
	echo "FILE_NAME: '${FILE_NAME}'"
	echo "ARTIFACT_ID: ${ARTIFACT_ID}"

	curl \
			-H "Accept: application/vnd.github+json" \
			-H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
			-L -o "${FILE_NAME}" \
			https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/actions/artifacts/${ARTIFACT_ID}/zip 
done 
