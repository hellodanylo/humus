#!/usr/bin/env zsh

script_dir=${0:a:h}
image_name="humus"

docker build \
    --platform linux/arm/v7 \
    --build-arg ARCH=armhf \
    --target core \
    -t "${image_name}:latest-arm7" \
    $script_dir/../source

docker build \
    --platform linux/arm64/v8 \
    --build-arg ARCH=arm64 \
    --target core \
    -t "${image_name}:latest-arm8" \
    $script_dir/../source

docker build \
    --platform linux/amd64 \
    --build-arg ARCH=amd64 \
    --target core \
    -t "${image_name}:latest-amd64" \
    $script_dir/../source
