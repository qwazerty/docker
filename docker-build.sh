#!/bin/bash

DOCKER=docker
NO_CACHE=

usage() {
    echo "Usage:"
    echo -e "\t$0 [-a|--all]"
    echo -e "\t$0 [-c|--no-cache] Dockerfile..."
    echo "Example:"
    echo -e "\t$0 -c ./build/wheezy/nginx/Dockerfile"
}

build() {
    DOCKER_PATH=$(echo $1 | sed 's/.*build//' | cut -d/ -f2,3 | sed 's|/|-|')
    $DOCKER build $NO_CACHE --rm -t $DOCKER_PATH $(dirname $1)
}

# FIXME: Handle dependencies
full_build() {
    for i in $(find . -name Dockerfile); do
        build $i
    done
}

cd $(dirname $0)

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

while [ $# -gt 0 ]; do
    case "$1" in
        -c|--no-cache)
            NO_CACHE="--no-cache"
            shift
            ;;
        -a|--all)
            full_build
            exit 0
            ;;
        *)
            build $1
            shift
            ;;
    esac
done
