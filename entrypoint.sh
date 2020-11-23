#!/bin/sh
export RUNNER_ALLOW_RUNASROOT=1
export PATH=$PATH:/actions-runner
REPO=$1
PAT=$2
NAME=$3

cleanup() {
    token=$(curl -s -XPOST -H "authorization: token ${PAT}" \
        https://api.github.com/repos/${REPO}/actions/runners/registration-token |\
        jq -r .token)
    ./config.sh remove --token $token
}

token=$(curl -s -XPOST \
    -H "authorization: token ${PAT}" \
    https://api.github.com/repos/wayofthepie/gh-app-test/actions/runners/registration-token |\
    jq -r .token)

./config.sh \
    --url https://github.com/${REPO}/${REPO} \
    --token ${token} \
    --name ${NAME} \
    --work _work

./run.sh

cleanup