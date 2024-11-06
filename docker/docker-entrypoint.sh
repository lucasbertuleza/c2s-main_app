#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /usr/src/app/tmp/pids/server.pid

# Setup database
bin/rails db:create; bin/rails db:migrate

# Install npm packages in development mode
if [ "$RAILS_ENV" = "development" ] && [ ! -d "node_modules" ]; then
  echo "Installing npm packages... 📦"
  npm install --silent
  echo -e "Done!\n"
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"