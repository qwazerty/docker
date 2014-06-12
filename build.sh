#!/bin/bash

usage() {
    echo "Usage: $0 [-a|--all] [Dockerfile] ..."
}

build() {
    DOCKER_PATH=$(echo $1 | sed 's/.*build//' | cut -d/ -f2,3 | sed 's|/|-|')
    docker build --rm -t $DOCKER_PATH $(dirname $1)
}

full_build() {
    for i in $(find . -name Dockerfile); do
        build $i
    done
}

cd $(dirname $0)

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

while [ $# -gt 0 ]; do
    case "$1" in
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
