#!/bin/sh

# Stick this somewhere that has reliable access to docker
# (i.e. probably the docker server itself)
# and then add it to cron:
#  0 */12 * * * perl -e 'sleep int(rand(3600))' && /path/to/renew.sh

set -e -x
docker start --attach certbot
docker exec nginx nginx -s reload
