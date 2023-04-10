# GEOS Docker Images

This repo contains a Dockerfile used to create alpine images that contain
historic GEOS versions installed from source.

## Instructions for building images on an EC2 instance

Assumes using an `amd64` node with Ubuntu Linux. `t2.medium` should be large
enough.

Install `docker`:
```sh
sudo snap install docker
sudo groupadd docker
sudo usermod -aG docker $USER
reboot # maybe running 'newgrp docker' would work instead?
docker run hello-world
```

Set up buildx:
```sh
docker buildx create --name mybuilder
docker buildx use mybuilder
```

Login to dockerhub:
```sh
docker login # interactive
```

Build and push the images:
```sh
GEOS_VERSION=3.11.2
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag peterstace/simplefeatures-ci:geos-${GEOS_VERSION} \
  --build-arg GEOS_VERSION=${GEOS_VERSION} \
  --push .
```
