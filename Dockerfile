# Use Alpine Linux as the base image
FROM alpine AS builder

# Install build dependencies
RUN apk update && apk add --no-cache \
    build-base \
    wget \
    cmake

# Download and extract GEOS source code
ARG GEOS_VERSION=3.10.2
WORKDIR /tmp
RUN wget https://download.osgeo.org/geos/geos-$GEOS_VERSION.tar.bz2 && \
    tar -xf geos-$GEOS_VERSION.tar.bz2 && \
    rm geos-$GEOS_VERSION.tar.bz2

# Build and install GEOS
WORKDIR /tmp/geos-$GEOS_VERSION
RUN cmake . -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make -j4 && \
    make install

# Use a multi-stage build to create the final image
FROM alpine
COPY --from=builder /usr/local/ /usr/local/

# Set the library path
ENV LD_LIBRARY_PATH=/usr/local/lib

# Run ldconfig to update library cache
RUN ldconfig /etc/ld.so.conf.d/

# Set default command
CMD ["geos-config", "--version"]
