# GEOS Docker Images

This repo contains a Dockerfile used to create alpine images that contain
historic GEOS versions installed from source.

## Set up buildx

This is only needed once (if you haven't set up `buildx` before).

```sh
docker buildx create --name mybuilder
docker buildx use mybuilder
```

## Build/push images

```sh
GEOS_VERSION=3.11.2
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag peterstace/geos:${GEOS_VERSION} \
  --build-arg GEOS_VERSION=${GEOS_VERSION} \
  --push .
```
