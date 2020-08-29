# dockerfiles

Some Dockerized applications with an aim for complete integration with a
desktop environment (at the known expense of security).

## Prerequisites

* Modern Docker
* GNU make
* D-Bus
* [`x11docker`](https://github.com/mviereck/x11docker)
* [`xdg-dbus-proxy`](https://github.com/flatpak/xdg-dbus-proxy) (available in
    Debian/Ubuntu as `xdg-dbus-proxy`)

## TODO

* Take advantage of [`ScreenCast`](https://flatpak.github.io/xdg-desktop-portal/portal-docs.html#gdbus-org.freedesktop.portal.ScreenCast)
  when apps start supporting it.

