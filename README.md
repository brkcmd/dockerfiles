# dockerfiles

Some Dockerized applications with an aim for complete integration with a
desktop environment (at the known expense of security).

## Prerequisites

* Modern Docker
* GNU make
* D-Bus
* [`x11docker`](https://github.com/mviereck/x11docker)

## TODO

* Figure out how to use [`flatpak/xdg-dbus-proxy`](https://github.com/flatpak/xdg-dbus-proxy)
  to limit access to host D-Bus to only allowed interfaces.
* Take advantage of [`ScreenCast`](https://flatpak.github.io/xdg-desktop-portal/portal-docs.html#gdbus-org.freedesktop.portal.ScreenCast)
  when apps start supporting it.

