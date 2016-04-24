#!/bin/bash

if [ "$STEAMLINK_HOST" == "" ]; then
    echo "STEAMLINK_HOST must be set."
    exit 1
fi

scp -r build/kappa root@${STEAMLINK_HOST}:/mnt/disk
scp -r build/steamlink/apps/* root@${STEAMLINK_HOST}:apps/

