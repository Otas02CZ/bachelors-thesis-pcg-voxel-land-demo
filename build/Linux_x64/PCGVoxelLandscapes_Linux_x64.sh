#!/bin/sh
printf '\033c\033]0;%s\a' PCGVoxelLandscapes
base_path="$(dirname "$(realpath "$0")")"
"$base_path/PCGVoxelLandscapes_Linux_x64.x86_64" "$@"
