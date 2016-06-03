#!/bin/bash -e

IMAGE_ELASTICSEARCH_BASE="choffmeister/elasticsearch-prefilled"
IMAGE_ELASTICSEARCH_TEMP="epages-docs-elasticsearch-${RANDOM}${RANDOM}${RANDOM}"

IMAGE_ELASTICSEARCH="epages/docs-elasticsearch"
IMAGE_NGINX="epages/docs-nginx"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${DIR}"

TAG="$1"
ELASTICSEARCH="$2"

bundle install
bundle exec jekyll build

# build elasticsearch image
docker run --name "${IMAGE_ELASTICSEARCH_TEMP}" -p 9200:9200 -d "${IMAGE_ELASTICSEARCH_BASE}"
sleep 15
if [ -z "${ELASTICSEARCH}" ]; then
  bundle exec jekyll index
else
  JEKYLL_SEARCH_HOST="${ELASTICSEARCH}" bundle exec jekyll index
fi
sleep 15
docker stop "${IMAGE_ELASTICSEARCH_TEMP}"
docker commit "${IMAGE_ELASTICSEARCH_TEMP}" "${IMAGE_ELASTICSEARCH}:${TAG}"
docker rm -vf "${IMAGE_ELASTICSEARCH_TEMP}" || true

# build nginx image
docker build -t "${IMAGE_NGINX}:${TAG}" -f Dockerfile.nginx .
