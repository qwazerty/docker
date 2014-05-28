#!/bin/bash

usage() {
    echo "Usage: $0 <path_to_dockerfile>"
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

docker build -t $(cut -d/ -f2,3 <<< $1 | sed 's#/#-#') $(cut -d/ -f-3 <<< $1)
