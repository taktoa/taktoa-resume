#!/usr/bin/env bash

function getContributions () {
    (( $# == 2 )) || return 1
    local OWNER REPO
    OWNER="$1"
    REPO="$2"
    curl -s "https://api.github.com/repos/${OWNER}/${REPO}/stats/contributors" \
        | jq 'map({"login": .author.login, "commits": (.weeks | map(.c) | add), "added": (.weeks | map(.a) | add), "deleted": (.weeks | map(.d) | add)})'
}

#curl -s "https://api.github.com/users/taktoa/repos?type=all&per_page=100&page=2" | jq 'map(.full_name)'

#getContributions awakesecurity language-ninja
