#!/bin/sh

script_path=/mlodata1/gpu-monitor/scripts

# check that bc is installed
if ! bc -v >> /dev/null; then
  echo "Please install package bc"
fi

# add cron tasks
(crontab -l 2>/dev/null; \
  echo "*/5 * * * * $script_path/gpu-check.sh $(hostname) > /dev/null 2>&1"; \
  echo "0 */2 * * * $script_path/gpu-check.sh kill > /dev/null 2>&1; $script_path/gpu-check.sh $(hostname) > /dev/null 2>&1") \
| crontab -
