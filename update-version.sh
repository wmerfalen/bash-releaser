#!/bin/bash

VERSION=$(cat ./VERSION | tr -d '[:space:]')

cat README.md | grep -E '^# Version$' -B 99999 > readme_a
echo "${VERSION}" >> readme_a
echo -ne "\n" >> readme_a
cat README.md | grep -E '^# Version$' -A 99999 > readme_tmp
LINES=$(wc -l readme_tmp | awk '{print $1}')
LINES=$(( $LINES - 3 ))
cat readme_tmp | tail -n $LINES >> readme_a

cat readme_a
rm readme_tmp
rm readme_a
