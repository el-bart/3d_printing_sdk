FROM debian:11
RUN apt-get update && apt-get install -y --no-install-recommends \
    coreutils \
    make \
    openscad \
    printrun-common \
    slic3r \
    yagv
COPY gcoder /usr/local/bin/
