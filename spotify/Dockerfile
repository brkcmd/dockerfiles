# Adapted from https://github.com/jessfraz/dockerfiles/blob/master/spotify/Dockerfile
FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        dirmngr \
        gnupg \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4773BD5E130D1D45 \
    && echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list \
    && apt-get update && apt-get install -y --no-install-recommends \
        alsa-utils \
        libgl1-mesa-dri \
        libgl1-mesa-glx \
        libpulse0 \
        dbus \
        spotify-client \
    && rm -rf /var/lib/apt/lists/*

# Debugging
# RUN apt-get update && apt-get install -y --no-install-recommends \
#         libnotify-bin \
#         lxterminal \
#         libglib2.0-bin \
#         xdg-utils \
#         busybox-static

ENV HOME /home/spotify

RUN useradd --create-home --home-dir $HOME spotify \
    && gpasswd -a spotify audio \
    && chown -R spotify:spotify $HOME

WORKDIR $HOME
USER spotify

# make search bar text better
RUN echo "QLineEdit { color: #000 }" > /home/spotify/spotify-override.css

ENTRYPOINT [ "spotify" ]
CMD [ "-stylesheet=/home/spotify/spotify-override.css" ]
