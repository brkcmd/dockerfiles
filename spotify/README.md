# Spotify

Features:

* Connects to host D-Bus for integration with browsers and MPRIS interface
* Persistent storage via Docker volume

Based off the excellent work of [`mviereck/x11docker`](https://github.com/mviereck/x11docker)
and [`jessfraz/dockerfiles:spotify/Dockerfile`](https://github.com/jessfraz/dockerfiles/blob/master/spotify/Dockerfile).

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
$ spotify [ARGS]
```
