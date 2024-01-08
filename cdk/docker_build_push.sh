#!/usr/bin/env zsh

set -eux

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO

docker run --privileged --rm public.ecr.aws/eks-distro-build-tooling/binfmt-misc:qemu-v7.0.0 --install arm64

function build_image() {
    platform=$1

    docker build \
        --build-arg ARCH=$platform \
        --build-arg "BASE_IMAGE=public.ecr.aws/ubuntu/ubuntu:22.04" \
        --target core \
        --tag "${ECR_REPO}:core-$platform" source
    docker push "${ECR_REPO}:core-$platform"

    docker build \
        --build-arg ARCH=$platform \
        --build-arg "BASE_IMAGE=public.ecr.aws/ubuntu/ubuntu:22.04" \
        --build-arg "user_id=1000" \
        --build-arg "user_name=user" \
        --build-arg "group_id=1000" \
        --build-arg "group_name=user" \
        --target user \
        --tag "${ECR_REPO}:user-$platform" source
    docker push "${ECR_REPO}:user-$platform"
}

build_image "amd64"
build_image "arm64"

docker manifest create --amend "${ECR_REPO}:latest" "${ECR_REPO}:core-amd64" "${ECR_REPO}:core-arm64"
docker manifest annotate --arch "amd64" "${ECR_REPO}:latest" "${ECR_REPO}:core-amd64"
docker manifest annotate --arch "arm64" "${ECR_REPO}:latest" "${ECR_REPO}:core-arm64"
docker manifest push "${ECR_REPO}:latest" 

docker manifest create --amend "${ECR_REPO}:user-latest" "${ECR_REPO}:user-amd64" "${ECR_REPO}:user-arm64"
docker manifest annotate --arch "amd64" "${ECR_REPO}:user-latest" "${ECR_REPO}:user-amd64"
docker manifest annotate --arch "arm64" "${ECR_REPO}:user-latest" "${ECR_REPO}:user-arm64"
docker manifest push "${ECR_REPO}:user-latest"