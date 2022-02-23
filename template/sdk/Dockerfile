FROM debian:11
RUN apt-get update && apt-get install -y --no-install-recommends \
    assimp-utils \
    coreutils \
    make \
    openscad \
    printrun-common \
    prusa-slicer \
    slic3r \
    yagv
COPY gcoder /usr/local/bin/
