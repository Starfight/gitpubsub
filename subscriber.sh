#!/bin/bash
# Subscriber example for gitpubsub
URL="http://localhost:2069/json"
PROJECT="myproject.git"
BRANCH="master"

while read chunk; do
  # keep only commit
  if [ "$(echo $chunk | jq -r .commit)" != "null" ]; then
    project_chunk=$(echo $chunk | jq -r .commit.repository)
    ref_chunk=$(echo $chunk | jq -r .commit.ref)
    branch_chunk=${ref_chunk#refs/heads/}
    if [[ "$project_chunk"=="$PROJECT" && "$branch_chunk"=="$BRANCH" ]]; then
      echo "do somethings"
    fi 
  fi
done < <(curl -sN $URL)

