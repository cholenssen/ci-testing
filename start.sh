#!/bin/bash

export RUNNER_ALLOW_RUNASROOT=1
REPO=$ORGANIZATION
ACCESS_TOKEN=$ACCESS_TOKEN
echo  $ACCESS_TOKEN
REG_TOKEN=$(curl -sX POST  -H "Authorization: token ${ACCESS_TOKEN}" -H 'accept: application/vnd.github.v3+json' "https://api.github.com/repos/cholenssen/ci-testing/actions/runners/registration-token" | jq .token --raw-output)

if [[ -n "${ACCESS_TOKEN}" ]]; then
  _TOKEN=$(bash /token.sh)
  RUNNER_TOKEN=$(echo "${_TOKEN}" | jq -r .token)
  _SHORT_URL=$(echo "${_TOKEN}" | jq -r .short_url)
fi

./config.sh --url "https://api.github.com/repos/cholenssen/ci-testing" --token "${REG_TOKEN}"

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!