# xlab/hermes image
#
# Used for running hermes in docker containers
#
# Usage:
#   docker build . --build-arg TAG=v0.6.2-inj2 -t xlab/hermes:v0.6.2-inj2 -f hermes.Dockerfile

FROM rust:1.52-buster AS build-env

ARG TAG
WORKDIR /root

RUN git clone https://github.com/InjectiveLabs/ibc-rs
RUN cd ibc-rs && git checkout $TAG && cargo build --release


FROM debian:buster-slim
LABEL maintainer="max@injectiveprotocol.com"

# Add Python 3
RUN apt-get update -y && apt-get install python3 python3-toml -y

RUN useradd -m hermes -s /bin/bash
WORKDIR /home/hermes
USER hermes:hermes
ENTRYPOINT ["/usr/bin/hermes"]

COPY --chown=0:0 --from=build-env /usr/lib/x86_64-linux-gnu/libssl.so.1.1 /usr/lib/x86_64-linux-gnu/libssl.so.1.1
COPY --chown=0:0 --from=build-env /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1
COPY --chown=0:0 --from=build-env /root/ibc-rs/target/release/hermes /usr/bin/hermes
