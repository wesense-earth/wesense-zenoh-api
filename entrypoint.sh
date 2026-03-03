#!/bin/sh
# entrypoint.sh — Fix directory ownership then drop to PUID:PGID
set -e

PUID="${PUID:-1000}"
PGID="${PGID:-1000}"

# Ensure writable directories exist with correct ownership
mkdir -p /app/logs
chown -R "$PUID:$PGID" /app/logs

exec setpriv --reuid="$PUID" --regid="$PGID" --clear-groups \
    python -u zenoh_api.py "$@"
