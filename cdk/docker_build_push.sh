#!/usr/bin/env zsh

set -eux

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO

# docker run --privileged --rm public.ecr.aws/eks-distro-build-tooling/binfmt-misc:qemu-v7.0.0 --install arm64

function build_image() {
    platform=$1
    image="public.ecr.aws/ubuntu/ubuntu:22.04"
    docker pull --platform "$platform" "$image"

    docker build \
        --platform $platform \
        --build-arg ARCH=$platform \
        --build-arg "BASE_IMAGE=$image" \
        --target core \
        --tag "${ECR_REPO}:core-$platform" source
    docker push "${ECR_REPO}:core-$platform"

    docker build \
        --platform $platform \
        --build-arg ARCH=$platform \
        --build-arg "BASE_IMAGE=$image" \
        --build-arg "user_id=1000" \
        --build-arg "user_name=user" \
        --build-arg "group_id=1000" \
        --build-arg "group_name=user" \
        --target user \
        --tag "${ECR_REPO}:user-$platform" source
    docker push "${ECR_REPO}:user-$platform"
}

build_image "$1"
