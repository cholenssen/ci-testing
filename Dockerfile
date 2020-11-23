FROM ubuntu

ENV RUNNER_VERSION=2.274.2

RUN apt-get update \
    && apt-get install -y \
    wget \
    # add curl and jq
    curl \
    jq

WORKDIR /actions-runner

RUN  wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz 
RUN  chmod +x sudo ./bin/installdependencies.sh



COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]