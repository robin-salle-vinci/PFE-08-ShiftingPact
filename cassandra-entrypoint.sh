#!/bin/bash
set -e

# Start Cassandra in the background
/usr/local/bin/docker-entrypoint.sh "$@" &

# Wait for Cassandra to be ready
until cqlsh -e 'describe keyspaces'; do
  echo "Waiting for Cassandra to be ready..."
  sleep 5
done

# Execute the initdb.cql script
echo "Executing initdb.cql..."
cqlsh -f /docker-entrypoint-initdb.d/initdb.cql

# Keep the container running
tail -f /dev/null