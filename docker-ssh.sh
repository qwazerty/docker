#!/bin/sh

usage() {
    echo "Usage: $0 DOCKER_ID [SSH_ARGS]..."
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

CONTAINER_IMAGE="$1"
shift

CONTAINER_ID=$(docker ps | grep $CONTAINER_IMAGE | awk '{ print $1 }')
CONTAINER_IP=$(docker inspect $CONTAINER_ID | grep 'IPAddress' | cut -d '"' -f4)

ssh root@$CONTAINER_IP $@
