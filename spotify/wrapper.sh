#!/usr/bin/env bash

if [ "$(docker container ls -q -f name=x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%%)" != "" ]; then
    if [ "$#" -eq 1 ]; then
        docker exec x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%% \
            dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
            /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri \
            string:"$1"
    fi
else
    exec x11docker \
        --user=RETAIN \
        --pulseaudio \
        --clipboard \
        --hostdbus \
        --name x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%% \
        -- \
            --mount type=volume,src=x11docker-home-%%REPONAME%%-%%APPNAME%%-%%TAG%%,dst=%%HOMEDIR%% \
        -- \
            %%REPONAME%%/%%APPNAME%%:%%TAG%% \
            --uri="$@"
fi
