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
    ca-certificates \
    wget
RUN cd /opt && \
    wget -O prusa-slicer.AppImage "https://github.com/prusa3d/PrusaSlicer/releases/download/version_2.8.1/PrusaSlicer-2.8.1+linux-x64-newer-distros-GTK3-202409181416.AppImage" && \
    chmod 755 prusa-slicer.AppImage && \
    ./prusa-slicer.AppImage --appimage-extract && \
    ln -s /opt/squashfs-root/usr/bin/prusa-slicer      /usr/local/bin/prusa-slicer      && \
    ln -s /opt/squashfs-root/usr/bin/prusa-gcodeviewer /usr/local/bin/prusa-gcodeviewer && \
    rm -vf ./prusa-slicer.AppImage
# deps of the slicer
RUN apt-get update && apt-get install -y --no-install-recommends \
    libsoup2.4-1 \
    libwebkit2gtk-4.1-0

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
