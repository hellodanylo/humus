#!/usr/bin/env bash

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
image_name="humus"

user_id=$(id | sed 's/uid=\([0-9]*\)(\([a-zA-Z]*\)).*/\1/')
user_name=$(id | sed 's/uid=\([0-9]*\)(\([a-zA-Z]*\)).*/\2/')
group_id=$(id | sed 's/.*gid=\([0-9]*\)(\([a-zA-Z]*\)).*/\1/')
group_name=$(id | sed 's/.*gid=\([0-9]*\)(\([a-zA-Z]*\)).*/\2/')


docker build \
    --target user \
    --build-arg user=$user_name \
    --build-arg user_id=$user_id \
    --build-arg group=$group_name \
    --build-arg group_id=$group_id \
    -t $image_name:latest-$user_name \
    $script_dir/../source
