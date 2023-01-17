export CUR_DIR=$(pwd)
mkdir data


# Building Debian based Node-Red docker from official github repo

git clone https://github.com/node-red/node-red-docker.git
cd node-red-docker/docker-custom

export NODE_RED_VERSION=$(grep -oE "\"node-red\": \"(\w*.\w*.\w*.\w*.\w*.)" package.json | cut -d\" -f4)
echo "node-red version: ${NODE_RED_VERSION}"

docker build \
    --build-arg ARCH=amd64 \
    --build-arg NODE_VERSION=16 \
    --build-arg NODE_RED_VERSION=${NODE_RED_VERSION} \
    --build-arg OS=buster-slim \
    --build-arg BUILD_DATE="$(date +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg TAG_SUFFIX=default \
    --file Dockerfile.debian \
    --tag node-red-debian:latest .
    
cd $CUR_DIR

# Starting docker compose, to build custom docker image with node red and pypylon
docker compose up
