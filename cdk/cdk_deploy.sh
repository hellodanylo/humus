#!/usr/bin/env zsh

set -eux

npm install -g aws-cdk
cd cdk && npx cdk deploy --all