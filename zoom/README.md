# Zoom

Features:

* Connects to host D-Bus for integration with browsers via `zoommtg` URI
* Connects to host X display (not secure!) to allow screen-sharing
* Persistent storage via Docker volume
* Bind mounts `~/Documents/Zoom` to allow access to local recordings

Based off the excellent work of [`mviereck/x11docker`](https://github.com/mviereck/x11docker)
and [`mdouchement/docker-zoom-us`](https://github.com/mdouchement/docker-zoom-us).

## Build

```console
$ make build
```

## Install to `~/.local/bin` and `~/.local/share/{applications,icons}`

```console
$ make install
```

## Use

```console
$ zoom [ARGS]
```
