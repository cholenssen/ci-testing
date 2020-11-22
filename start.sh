#!/bin/bash

cd /home/docker/actions-runner

./config.sh --url https://github.com/cholenssen/ci-testing --token AB5B4XTT33Y273TTFUD3V4K7XMBLI

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token AB5B4XTT33Y273TTFUD3V4K7XMBLI
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!