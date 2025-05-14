#!/bin/bash
set -e

echo "🟢 Starting Pi-hole..."

# Start lighttpd and FTLDNS
service lighttpd start
exec pihole-FTL
