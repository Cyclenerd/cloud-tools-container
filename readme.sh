#!/usr/bin/env bash

#
# Update shield in README.md with date of last build
#
# [![Latest build](https://img.shields.io/badge/Last%20build-1900--01--01-blue)](https://github.com/Cyclenerd/cloud-tools-container/actions/workflows/docker-latest.yml)
#

# GitHub Action runner
if [ -v GITHUB_RUN_ID ]; then
	echo "» Set git username and email"
	git config user.name "github-actions[bot]"
	git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
fi

MY_DATE=$(date --utc +'%Y--%m--%d')
export MY_DATE

perl -i -pe's|\d{4}--\d{2}--\d{2}|$ENV{MY_DATE}|' "README.md"

if ! git diff --exit-code "README.md"; then
	echo "README.md changed!"
	git add "README.md" || exit 9
	git commit -m "Last build" || exit 9
	git push || exit 9
else
	echo "README.md not changed."
fi

echo "DONE"