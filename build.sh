#!/bin/bash -e

IMAGE_NGINX="epages/docs-nginx"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${DIR}"

TAG="$1"

bundle exec jekyll build

# build nginx image
docker build -t "${IMAGE_NGINX}:${TAG}" -f Dockerfile.nginx .
