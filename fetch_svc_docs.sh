#!/bin/bash
echo "-- get service docs --"

# check environment variable
: ${PEGASUSAPI?"Need to set env var PEGASUSAPI to e.g. pegasus-api-dev.hosted.exosite.io or localhost:8080"}

# check environment variable
: ${PEGASUSTOKEN?"Need to set env var PEGASUSTOKEN"}

if cd reference/services; then
    rm ./*
else
    echo "Could not change directory! Aborting." 1>&2
    exit 1
fi

wget --no-verbose http://${PEGASUSAPI}/service/doc.md?token=${PEGASUSTOKEN} -O README.md || exit 1
 
# remove erroneous lines coming out of pegasus generated docs
# once that's fixed this can be removed
grep -v '\[[0-9]*\]' ./README.md | grep -v '_meta_schema.md' > README.fixed.md ;  mv README.fixed.md README.md

# remove Auth0 from docs
grep -v Auth0 ./README.md > README.fixed.md ; mv README.fixed.md README.md

# remove .md extensions. Once that's fixed in pegasus-api this can be removed
cat README.md | sed 's/.md)/)/g' > README.fixed.md ; mv README.fixed.md README.md

while read line; do
    if [[ $line =~ \.\/([a-z0-9]+)\.md ]]; then
        echo "Getting doc for Service: ${BASH_REMATCH[1]}"
        wget --no-verbose http://${PEGASUSAPI}/service/${BASH_REMATCH[1]}/doc.md?token=${PEGASUSTOKEN} -O ${BASH_REMATCH[1]}.md || exit 1
    fi
done <README.md
