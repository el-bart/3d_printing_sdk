FROM debian:11
# core SDK utils
RUN apt-get update && apt-get install -y --no-install-recommends \
    assimp-utils \
    coreutils \
    make \
    openscad \
    prusa-slicer \
    slic3r \
    yagv

# install newer version of prusa-slicer
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

# install gcoder
RUN apt-get update && apt-get install -y --no-install-recommends \
    printrun-common \
    patch
COPY gcoder /usr/local/bin/
COPY gcoder.patch /opt/
RUN patch -p0 < /opt/gcoder.patch

# install custom config.ini merger
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3
COPY merge_ini /usr/local/bin/
