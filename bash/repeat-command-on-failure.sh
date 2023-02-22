#!/bin/bash

set -eu


attempts=1
max_attempts=10
while [ $attempts -lt $max_attempts ]; do
    echo "Attempt $attempts of $max_attempts to run kubectl apply"
    sleep 1
    attempts=$((attempts+1))
    ls / && attempts=10
done

