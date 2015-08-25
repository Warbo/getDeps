#! /usr/bin/env nix-shell
#! nix-shell -p getdeps -p bash -p jq -i bash

jq -c '.[]'
    while read -r LINE
    do
        # Extract the "ast" value and pipe into TreeFeatures
        DEPENDENCIES=$(echo "$LINE" | jq -r '.ast' | GetDeps )
        [[ -z "$DEPENDENCIES" ]] && echo "LINE: $LINE" >> /dev/stderr
        
        # Add the features to the object
        echo "$LINE" | jq -c ". + {\"dependencies\": $DEPENDENCIES }"
    done  | jq -s '.'
