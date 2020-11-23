FROM ubuntu

ENV RUNNER_VERSION=2.164.0

RUN apt-get update \
    && apt-get install -y \
    wget \
    # add curl and jq
    curl \
    jq

RUN wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && ./bin/installdependencies.sh

COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]