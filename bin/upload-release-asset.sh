#!/bin/bash

if [[ $# -lt 5 ]]; then
	echo 'Usage: upload-release-asset.sh USER REPO RELEASE_ID PATH_TO_ASSET NAME_OF_ASSET'
	exit 1
fi

if [[ ! -d $PWD/.tmp ]]; then
	mkdir $PWD/.tmp
fi

GITHUB_USER=$(./bin/lib/sanitize-github-username.sh "$1")
GITHUB_REPO=$(./bin/lib/sanitize-github-reponame.sh "$2")
GITHUB_RELEASE_ID=$(./bin/lib/intval.sh "$3")
GITHUB_PATH_TO_ASSET="$4"
shift
shift
shift
shift
GITHUB_NAME_OF_ASSET="$*"

echo "GITHUB_RELEASE_ID: '${GITHUB_RELEASE_ID}'"
echo "GITHUB_USER: '${GITHUB_USER}'"
echo "GITHUB_REPO: '${GITHUB_REPO}'"
echo "GITHUB_PATH_TO_ASSET: '${GITHUB_PATH_TO_ASSET}'"
echo "GITHUB_NAME_OF_ASSET: '${GITHUB_NAME_OF_ASSET}'"

echo -n "${GITHUB_NAME_OF_ASSET}" > $PWD/.tmp/__tmp

if [[ ! -z "${GITHUB_DONT_SEND}" ]]; then
	echo '... GITHUB_DONT_SEND is set, so we will be exiting before the curl command happens'
	rm $PWD/.tmp/__tmp
	exit 0
fi

PREFIX=https://uploads.github.com

curl --head -v https://uploads.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/releases/${GITHUB_RELEASE_ID}/assets -G --data-urlencode name@$PWD/.tmp/__tmp 2>&1 | grep -E '^> HEAD /' > haxx
cat haxx | sed -E 's|^> HEAD ||' | cut -d' ' -f1 > $PWD/.tmp/url
rm haxx

URL=$(cat $PWD/.tmp/url | tr -d '[:space:]')
rm $PWD/.tmp/url
URL="${PREFIX}${URL}"

echo "URL: '${URL}'"

curl \
		-X POST \
	  -H "Accept: application/vnd.github+json" \
	  -H "Authorization: Bearer ${GITHUB_ACCESS_TOKEN}" \
		-H "Content-Type: application/zip" \
		"${URL}" \
  	--data-binary "@${GITHUB_PATH_TO_ASSET}"
