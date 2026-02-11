#! /bin/bash

podman kill redi-prod
podman container prune -f
