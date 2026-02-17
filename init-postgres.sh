#!/bin/bash
set -e

# Configure PostgreSQL to accept connections from all hosts
echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf

# Reload PostgreSQL configuration
psql -U postgres -c "SELECT pg_reload_conf();"
