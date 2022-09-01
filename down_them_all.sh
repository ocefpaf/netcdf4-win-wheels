#!/bin/bash

mkdir -p dist
cd dist

version=$1
version_post=$2

if [[ "$1" == "" ]]; then
    echo "Usage: down_them_all.sh <version>"
    exit 1
fi

declare -a arr=(
	"-cp37-cp37m-win_amd64.whl"
	"-cp38-cp38-win_amd64.whl"
	"-cp39-cp39-win_amd64.whl"
	"-cp310-cp310-win_amd64.whl"
	".tar.gz")
for whl_file in "${arr[@]}"
do
    curl -L -O https://github.com/ocefpaf/netcdf4-win-wheels/releases/download/v${version}${version_post}/netcdf4-${version}${whl_file};
done


