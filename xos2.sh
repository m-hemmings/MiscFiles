#!/bin/bash

./cord-bootstrap.sh -d
cd ~/cord/build && make PODCONFIG=frontend-local.yml config && make local-ubuntu-dev-env && make build
