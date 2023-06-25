#!/usr/bin/env zsh

set -eux

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
docker build \
    --build-arg ARCH=amd64 \
    --build-arg "BASE_IMAGE=public.ecr.aws/ubuntu/ubuntu:22.04" \
    --target core \
    --tag "${ECR_REPO}:main" source

docker push "${ECR_REPO}:main"
docker tag "${ECR_REPO}:main" "${ECR_REPO}:latest"
docker push "${ECR_REPO}:latest"

docker build \
    --build-arg ARCH=amd64 \
    --build-arg "BASE_IMAGE=public.ecr.aws/ubuntu/ubuntu:22.04" \
    --build-arg "user_id=1000" \
    --build-arg "user_name=user" \
    --build-arg "group_id=1000" \
    --build-arg "group_name=user" \
    --target user \
    --tag "${ECR_REPO}:user-latest" source

docker push "${ECR_REPO}:user-latest"