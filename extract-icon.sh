#!/bin/sh
if [ "$#" != 2 ]; then
    echo "Usage $0 IMAGE FILE"
    exit 1
fi
exec docker run --rm --entrypoint="" $1 cat $2
