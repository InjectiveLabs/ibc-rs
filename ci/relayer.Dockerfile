#####################################################
####                 Relayer image               ####
#####################################################
FROM xlab/hermes:latest
LABEL maintainer="max@injectiveprotocol.com"

ARG RELEASE

# Relayer folder
WORKDIR /home/hermes/relayer

# Copy configuration file
COPY ci/simple_config.toml .

# Copy setup script
COPY ci/e2e.sh .

# Copy end-to-end testing script
COPY e2e ./e2e

# Copy key files
COPY ci/chains/injective/$RELEASE/ibc-10/user_seed.json  ./user_seed_ibc-10.json
COPY ci/chains/injective/$RELEASE/ibc-11/user_seed.json  ./user_seed_ibc-11.json
COPY ci/chains/injective/$RELEASE/ibc-10/user2_seed.json ./user2_seed_ibc-10.json
COPY ci/chains/injective/$RELEASE/ibc-11/user2_seed.json ./user2_seed_ibc-11.json

ENTRYPOINT ["/bin/sh"]
