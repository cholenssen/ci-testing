#!/bin/bash
REPO=$ORGANIZATION
ACCESS_TOKEN=$ACCESS_TOKEN
 
REG_TOKEN=$(curl --location --request POST 'https://api.github.com/repos/cholenssen/ci-testing/actions/runners/registration-token'  --header 'Authorization: token 2247b40121962692430061ae4e3d5be37f7d7880' --header 'accept: application/vnd.github.v3+json' | jq .token --raw-output)

cd /home/docker/actions-runner

./config.sh --url https://github.com/${REPO} --token ${REG_TOKEN}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!