#!/usr/bin/env bash

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
image_name="humus"

docker build \
    --platform linux/arm/v7 \
    --build-arg BASE_IMAGE=arm32v7/ubuntu:20.04 \
    --build-arg ARCH=armhf \
    --target core \
    -t $image_name:latest-arm7 \
    $script_dir/../source

docker build \
    --platform linux/amd64 \
    --build-arg ARCH=amd64 \
    --target core \
    -t $image_name:latest-amd64 \
    $script_dir/../source
