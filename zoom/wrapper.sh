#!/usr/bin/env bash

if [ "$(docker container ls -q -f name=x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%%)" != "" ]; then
    if [ "$#" -eq 0 ]; then
        # Restart the container
        docker container stop x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%%
        exec "$0" "$@"
    else
        docker exec x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%% %%EXE%% "$@"
    fi
else
    XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
    DOCUMENTS_DIR="$(xdg-user-dir DOCUMENTS)/Zoom"
    mkdir -p "${DOCUMENTS_DIR}"
    DBUS_PROXY_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/.dbus-proxy"
    mkdir -p "${DBUS_PROXY_DIR}"
    DBUS_PROXY_PATH="${DBUS_PROXY_DIR}/x11docker-%%REPONAME%%-%%APPNAME%%-bus"
    xdg-dbus-proxy \
        "${DBUS_SESSION_BUS_ADDRESS:?No DBus session bus detected.}" "${DBUS_PROXY_PATH}" \
        --filter \
        --call=org.freedesktop.portal.Desktop.*=* \
        --broadcast=org.freedesktop.portal.Desktop.*=@/org/freedesktop/portal/desktop/* \
        &  # run proxy in background
    declare proxy_pid=$!
    x11docker \
        --user=RETAIN \
        --pulseaudio \
        --webcam \
        --clipboard \
        --hostdisplay \
        --name x11docker-%%REPONAME%%-%%APPNAME%%-%%TAG%% \
        -- \
            --mount type=volume,src=x11docker-home-%%REPONAME%%-%%APPNAME%%-%%TAG%%,dst=%%HOMEDIR%% \
            --mount "type=bind,src=${DOCUMENTS_DIR},dst=%%HOMEDIR%%/Documents/Zoom" \
            --mount "type=bind,src=${DBUS_PROXY_PATH},dst=/run/user/1000/bus,readonly" \
            --env DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus" \
        -- \
            %%REPONAME%%/%%APPNAME%%:%%TAG%% \
            "$@"
    kill "$proxy_pid"
    wait  # ensure proxy has exited
fi
