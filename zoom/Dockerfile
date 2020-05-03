# Adapted from the excellent work at https://github.com/mdouchement/docker-zoom-us
FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive
ARG ZOOM_URL=https://zoom.us/client/latest/zoom_amd64.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
        dirmngr \
        gnupg \
        alsa-utils \
        libgl1-mesa-dri \
        libgl1-mesa-glx \
        libpulse0 \
        lib32z1 \
        libx11-6 \
        libegl1-mesa \
        libxcb-shm0 \
        libglib2.0-0 \
        libgl1-mesa-glx \
        libxrender1 \
        libxcomposite1 \
        libxslt1.1 \
        libgstreamer1.0-0 \
        libgstreamer-plugins-base1.0-0 \
        libxi6 \
        libsm6 \
        libfontconfig1 \
        libpulse0 \
        libsqlite3-0 \
        libxcb-shape0 \
        libxcb-xfixes0 \
        libxcb-randr0 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-xtest0 \
        libnss3 \
        libxss1 \
        pulseaudio-utils \
        ibus \
        ibus-gtk \
        fonts-noto-color-emoji \
        curl ca-certificates \
        flatpak-xdg-utils \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/libexec/flatpak-xdg-utils/xdg-open /usr/bin/xdg-open

ENV HOME /home/zoom

RUN useradd --create-home --home-dir $HOME zoom \
    && gpasswd -a zoom audio \
    && gpasswd -a zoom video \
    && chown -R zoom:zoom $HOME

COPY trustedkeys.gpg /tmp/
RUN curl -sSL $ZOOM_URL -o /tmp/zoom_setup.deb \
    && gpgv --keyring /tmp/trustedkeys.gpg /tmp/zoom_setup.deb \
    && dpkg -i /tmp/zoom_setup.deb \
    && apt-get -f install \
    && rm /tmp/zoom_setup.deb /tmp/trustedkeys.gpg

# Debugging
# RUN apt-get update && apt-get install -y --no-install-recommends \
#         libnotify-bin \
#         lxterminal \
#         libglib2.0-bin \
#         xdg-utils \
#         busybox-static

WORKDIR $HOME
USER zoom
ENTRYPOINT [ "zoom" ]
