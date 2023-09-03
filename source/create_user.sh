#!/usr/bin/env zsh

set -eux

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

adduser $user_name docker

echo "$user_name ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

mkdir /home/$user_name/opt
cd /home/$user_name/opt

cp -r $HUMUS_PATH ./humus
sudo chown -R $user_name:$group_name .
sudo -u $user_name ./humus/symlink.sh ./humus
