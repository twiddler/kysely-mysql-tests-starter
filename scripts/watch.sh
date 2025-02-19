#!/bin/bash

set -e

cleanup() {
    ./scripts/stop.sh
}

trap cleanup EXIT

./scripts/start.sh

node --test --watch
