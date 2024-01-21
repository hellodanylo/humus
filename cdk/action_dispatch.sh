#!/usr/bin/env bash

set -eux

if [ -x "$(command -v apt-get)" ]; then
    apt-get update -yq 2>&1 >/dev/null
    apt-get install -yq zsh 2>&1 >/dev/null
else
    yum install -yq zsh 2>&1 >/dev/null
fi

action=$1

if [ "$action" == build-arm64 ]; then
    ./cdk/docker_build_push.sh arm64
elif [ "$action" == build-amd64 ]; then
    ./cdk/docker_build_push.sh amd4
elif [ "$action" == deploy ]; then
    ./cdk/docker_manifest_push.sh
    ./cdk/cdk_deploy.sh
else
    echo "Unknown action $action"
    exit 1
fi