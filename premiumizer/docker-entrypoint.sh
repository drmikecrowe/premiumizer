#!/usr/bin/env sh

PUID=${PUID:-0}
PGID=${PGID:-0}

# Allow write access on downloaded files to group and others
umask 0000

if [ "$PUID" -eq 0 ]; then
    exec "$@"
fi

groupmod -o -g "$PGID" premiumizer || true
usermod -o -u "$PUID" premiumizer || true
chown -R premiumizer:premiumizer /conf || true

exec su-exec premiumizer "$@"
