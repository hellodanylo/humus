#!/usr/bin/env zsh

set -eux

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO

docker pull "${ECR_REPO}:core-amd64"
docker pull "${ECR_REPO}:core-arm64"

docker manifest rm "${ECR_REPO}:latest"
docker manifest create "${ECR_REPO}:latest" "${ECR_REPO}:core-amd64" "${ECR_REPO}:core-arm64"
docker manifest annotate --arch "amd64" "${ECR_REPO}:latest" "${ECR_REPO}:core-amd64"
docker manifest annotate --arch "arm64" "${ECR_REPO}:latest" "${ECR_REPO}:core-arm64"
docker manifest push "${ECR_REPO}:latest" 

docker pull "${ECR_REPO}:user-amd64"
docker pull "${ECR_REPO}:user-arm64"

docker manifest rm "${ECR_REPO}:user-latest"
docker manifest create "${ECR_REPO}:user-latest" "${ECR_REPO}:user-amd64" "${ECR_REPO}:user-arm64"
docker manifest annotate --arch "amd64" "${ECR_REPO}:user-latest" "${ECR_REPO}:user-amd64"
docker manifest annotate --arch "arm64" "${ECR_REPO}:user-latest" "${ECR_REPO}:user-arm64"
docker manifest push "${ECR_REPO}:user-latest"
