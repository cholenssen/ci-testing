FROM ubuntu

ENV RUNNER_VERSION=2.274.2

RUN apt-get update \
    && apt-get install -y \
    wget \
    # add curl and jq
    curl \
    jq

RUN mkdir actions-runner && cd actions-runner \
    && wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz 
WORKDIR /actions-runner

COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]