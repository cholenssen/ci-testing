# base
FROM ubuntu:18.04

RUN apt-get update -y && apt-get upgrade -y && useradd -m docker
RUN apt-get install -y curl

# set the github runner version
RUN cd /home/docker && mkdir actions-runner && cd actions-runner
RUN curl -O -L https://github.com/actions/runner/releases/download/v2.274.2/actions-runner-linux-x64-2.274.2.tar.gz
RUN tar xzf ./actions-runner-linux-x64-2.274.2.tar.gz

RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh


USER docker
RUN ./config.sh --url https://github.com/cholenssen/python-docker-debian --token AB5B4XUAKULVAE6RDVKFJVC7XL4KU

# set the entrypoint to the start.sh script
ENTRYPOINT  ["./run.cmd"]