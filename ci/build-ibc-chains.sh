#!/usr/bin/env bash

## Programmatic list for creating Gaia Hub chains for testing IBC.
## Instead of blindly running this code, read it line by line and understand the dependencies and tasks.
## Prerequisites: Log into Docker Hub
set -eou pipefail

## After updating the injective version below, double-check the following (see readme.md also):
##   - the new version made it to docker hub, and is available for download, e.g. `docker pull xlab/inj-ibc-1:v1.0.4-rc1`
##   - the image versions and the relayer release in `docker-compose.yml` are consistent with the new version
CORE_BRANCH="v1.0.4-rc1"

BASE_DIR="$(dirname $0)"
ONE_CHAIN="$BASE_DIR/../scripts/one-chain"

echo "*** Building config folders"

CHAIN_HOME="./chains/injective/$CORE_BRANCH"

# Clean home dir if exists
rm -Rf "$CHAIN_HOME"

# Create home dir
mkdir -p "$CHAIN_HOME"

ls -allh "$CHAIN_HOME"

# Check injective version
echo "-------------------------------------------------------------------------------------------------------------------"
echo "Injectived version"
echo "-------------------------------------------------------------------------------------------------------------------"
injectived version --log-level error

MONIKER=node_ibc_0
CHAIN_ID=ibc-10
CHAIN_IP=172.25.0.10
RPC_PORT=26657
GRPC_PORT=9090
CHAIN_INJ=100000000000
"$ONE_CHAIN" injectived "$CHAIN_ID" "$CHAIN_HOME" "$RPC_PORT" 26656 6060 "$GRPC_PORT" "$CHAIN_INJ"

MONIKER=node_ibc_1
CHAIN_ID=ibc-11
CHAIN_IP=172.25.0.11
RPC_PORT=26657
GRPC_PORT=9090
CHAIN_INJ=100000000000
"$ONE_CHAIN" injectived "$CHAIN_ID" "$CHAIN_HOME" "$RPC_PORT" 26656 6060 "$GRPC_PORT" "$CHAIN_INJ"

echo "*** Requirements"
which docker

echo "*** Create Docker image and upload to Docker Hub"
export DOCKER_BUILDKIT=1
docker build --ssh default --build-arg CHAIN=injective --build-arg RELEASE=$CORE_BRANCH --build-arg NAME=ibc-10 -f --no-cache -t xlab/inj-ibc-0:$CORE_BRANCH -f "$BASE_DIR/injective.Dockerfile" .
docker build --ssh default --build-arg CHAIN=injective --build-arg RELEASE=$CORE_BRANCH --build-arg NAME=ibc-11 -f --no-cache -t xlab/inj-ibc-1:$CORE_BRANCH -f "$BASE_DIR/injective.Dockerfile" .

read -p "Press ANY KEY to push image to Docker Hub, or CTRL-C to cancel. " dontcare
docker push xlab/inj-ibc-0:$CORE_BRANCH
docker push xlab/inj-ibc-1:$CORE_BRANCH
