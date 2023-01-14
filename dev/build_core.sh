#!/usr/bin/env zsh

script_dir=${0:a:h}
image_name="humus"

docker build \
    --platform linux/amd64 \
    --build-arg ARCH=amd64 \
    --target core \
    -t "${image_name}:latest" \
    $script_dir/../source
