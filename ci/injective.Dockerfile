# syntax=docker/dockerfile:experimental

###################################################################################################
# Build image
###################################################################################################
FROM golang:alpine AS build-env

# Add dependencies
RUN apk add --no-cache curl make git libc-dev bash gcc linux-headers eudev-dev python3 openssh

# Injective Core Branch or Release
ARG RELEASE

ENV GOPRIVATE=github.com/InjectiveLabs/injective-core/*
RUN git config --system url."ssh://git@github.com:InjectiveLabs/injective-core.git".insteadOf "https://github.com/InjectiveLabs/injective-core"
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# Set working directory for the build
WORKDIR /go/src/github.com/InjectiveLabs/injective-core

# Clone repository
RUN --mount=type=ssh git clone git@github.com:InjectiveLabs/injective-core.git /go/src/github.com/InjectiveLabs/injective-core

# Checkout branch
RUN git checkout $RELEASE

RUN --mount=type=ssh go mod download

# Install minimum necessary dependencies, build Cosmos SDK, remove packages
RUN apk add --no-cache $PACKAGES && make install

# Show version
RUN injectived version

###################################################################################################
# Final image
###################################################################################################
FROM alpine:edge
LABEL maintainer="max@injectiveprotocol.com"

ARG RELEASE
ARG CHAIN
ARG NAME

# Add jq for debugging
RUN apk add --no-cache jq curl tree

WORKDIR /$NAME

# Copy over binaries from the build-env
COPY --from=build-env /go/bin/injectived /usr/bin/injectived

COPY --chown=root:root ./chains/$CHAIN/$RELEASE/$NAME /chain/$CHAIN

RUN tree -pug /chain

ENTRYPOINT "/bin/sh"
