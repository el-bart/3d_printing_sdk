FROM debian:13
# core SDK utils
RUN apt-get update && apt-get install -y --no-install-recommends \
    assimp-utils \
    coreutils \
    make \
    openscad \
    prusa-slicer

# make it possible to use GUI in docker
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    locales && \
    sed -i -e 's|^# \(en_US.UTF-8 UTF-8\)|\1|' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

# install custom config.ini merger
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3
COPY merge_ini /usr/local/bin/
