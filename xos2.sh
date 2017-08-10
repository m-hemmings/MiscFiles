#!/bin/bash

cd ~/cord/build && make PODCONFIG=frontend-local.yml config && make local-ubuntu-dev-env && make build
