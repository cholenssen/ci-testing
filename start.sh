#!/bin/bash

export RUNNER_ALLOW_RUNASROOT=1
REPO=$ORGANIZATION
ACCESS_TOKEN=$ACCESS_TOKEN
echo  $ACCESS_TOKEN
REG_TOKEN=$(curl -sX POST  -H "Authorization: token ${ACCESS_TOKEN}" -H 'accept: application/vnd.github.v3+json' "https://api.github.com/repos/cholenssen/ci-testing/actions/runners/registration-token" | jq .token --raw-output)

./config.sh --url "https://api.github.com/repos/cholenssen/ci-testing" --token ${REG_TOKEN} --RUNNER_ALLOW_RUNASROOT 1

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!