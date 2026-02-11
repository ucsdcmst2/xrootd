#! /bin/bash

podman kill haproxy
podman container prune -f
