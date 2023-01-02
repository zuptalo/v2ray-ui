#!/bin/zsh

docker buildx build --platform=linux/amd64,linux/arm64 -t zuptalo/x-ui:latest --push .
