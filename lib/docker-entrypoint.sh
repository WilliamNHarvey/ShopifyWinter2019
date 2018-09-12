#!/bin/sh
set -e

if [ -f /www/tmp/pids/server.pid ]; then
  rm /www/tmp/pids/server.pid
fi

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup

exec bundle exec "$@"
