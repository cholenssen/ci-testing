#!/bin/bash

export RUNNER_ALLOW_RUNASROOT=1
REPO=$ORGANIZATION
ACCESS_TOKEN=$ACCESS_TOKEN

if [[ -n "${ACCESS_TOKEN}" ]]; then
  _TOKEN=$(bash /token.sh)
  RUNNER_TOKEN=$(echo "${_TOKEN}" | jq -r .token)
  _SHORT_URL=$(echo "${_TOKEN}" | jq -r .short_url)
fi

./config.sh \
    --url "${_SHORT_URL}" \
    --token "${RUNNER_TOKEN}" 

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${RUNNER_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!