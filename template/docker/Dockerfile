FROM debian:12
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
    wget "https://github.com/prusa3d/PrusaSlicer/releases/download/version_2.7.0/PrusaSlicer-2.7.0+linux-x64-GTK3-202311231454.tar.bz2" && \
    tar xvf *.tar.* && \
    rm -v *.tar.* && \
    ln -s Prusa* prusa-slicer && \
    ln -s /opt/prusa-slicer/bin/prusa-slicer /usr/local/bin/

# make it possible to use GUI in docker
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    locales && \
    sed -i -e 's|^# \(en_US.UTF-8 UTF-8\)|\1|' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

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
