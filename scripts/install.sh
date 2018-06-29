#!/bin/sh

set -x

MONITOR_PATH=$(readlink -f "$(dirname "$0")/..")
SCRIPT_PATH="$MONITOR_PATH/scripts"

# check that bc is installed
if ! bc -v >> /dev/null; then
  echo "Please install package bc"
fi

# add cron tasks
(crontab -l 2>/dev/null; \
  echo "*/5 * * * * $SCRIPT_PATH/gpu-check.sh $(hostname) > /dev/null 2>&1"; \
  echo "0 */2 * * * $SCRIPT_PATH/gpu-check.sh kill > /dev/null 2>&1; $SCRIPT_PATH/gpu-check.sh $(hostname) > /dev/null 2>&1") \
| crontab -

# build docker images
DOCKER_PATH="$MONITOR_PATH/docker"
echo "Building docker images in $DOCKER_PATH..."
MONITOR_UID=$(id -u)
MONITOR_GID=$(getent group MLO-unit | awk -F: '{printf "%d\n", $3}')
docker build --build-arg uid=$MONITOR_UID --build-arg gid=$MONITOR_GID -t mlo-nginx $DOCKER_PATH/nginx
docker build --build-arg uid=$MONITOR_UID --build-arg gid=$MONITOR_GID -t mlo-php $DOCKER_PATH/php
echo "Done."

# start web interface
docker-compose -f $DOCKER_PATH/docker-compose.yml up -d

