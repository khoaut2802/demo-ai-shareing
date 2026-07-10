#!/bin/bash
set -e

# Remove a stale server PID file if the container was killed uncleanly.
rm -f /app/tmp/pids/server.pid

# Ensure the sqlite database exists and migrations are applied.
bin/rails db:prepare

exec "$@"
