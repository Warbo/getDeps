#! /usr/bin/env nix-shell
#! nix-shell -p getdeps -p bash -p jq -i bash

jq -c '.[]' |
    while read -r LINE
    do
        # Extract the "ast" value and pipe into TreeFeatures
        FEATURES=$(echo "$LINE" | jq -r '.ast' | GetDeps)
        echo "$FEATURES"
        # Read the features as a raw string, and collect into an array
        #FEATARR=$(echo "$FEATURES" | jq -R '.' | jq -s '.')

        # Add the features to the object
        #echo "$LINE" | jq -c ". + {features: \"$FEATURES\"}"
    done #| jq -s '.'
