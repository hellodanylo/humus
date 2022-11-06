#!/usr/bin/env bash

set -o xtrace

user_id="$1"
user_name="$2"
group_id="$3"
group_name="$4"

groupadd \
    --force \
    --gid $group_id \
    $group_name

useradd \
    --uid $user_id \
    --gid $group_id \
    -G sudo \
    --create-home $user_name \
    --shell /bin/zsh

echo "$user_name ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

sudo -u $user_name $HUMUS_PATH/symlink.sh $HUMUS_PATH
