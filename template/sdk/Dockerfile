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

# install newer version of PS
RUN apt-get update && apt-get install -y --no-install-recommends \
    bzip2 \
    ca-certificates \
    wget
RUN cd /opt && \
    wget "https://github.com/prusa3d/PrusaSlicer/releases/download/version_2.5.0/PrusaSlicer-2.5.0+linux-x64-GTK3-202209060725.tar.bz2" && \
    tar xvf *.tar.* && \
    rm -v *.tar.* && \
    ln -s Prusa* prusa-slicer && \
    ln -s /opt/prusa-slicer/bin/prusa-slicer /usr/local/bin/
