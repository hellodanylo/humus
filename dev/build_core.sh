#!/usr/bin/env bash

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
image_name="humus"

docker build --target core -t $image_name $script_dir/../source
