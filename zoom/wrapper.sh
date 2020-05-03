#/usr/bin/env bash

if [ "$(docker container ls -q -f name=x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%%)" != "" ]; then
    if [ "$#" -eq 0 ]; then
        # Restart the container
        docker container stop x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%%
        exec "$0" "$@"
    else
        docker exec x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%% %%EXE%% "$@"
    fi
else
    declare DOCUMENTS_DIR="$(xdg-user-dir DOCUMENTS)/Zoom"
    mkdir -p "${DOCUMENTS_DIR}"
    exec x11docker \
        --user=RETAIN \
        --pulseaudio \
        --webcam \
        --clipboard \
        --hostdisplay \
        --hostdbus \
        --name x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%% \
        -- \
            --mount type=volume,src=x11docker-home-%%REPONAME%%-%%APPNAME%%-%%TAG%%,dst=%%HOMEDIR%% \
            --mount "type=bind,src=${DOCUMENTS_DIR},dst=%%HOMEDIR%%/Documents/Zoom" \
        -- \
            %%REPONAME%%/%%APPNAME%%:%%TAG%% \
            "$@"
fi
