# MLO Docker deployment

## Deployment

Add user to groups docker
```
sudo usermod -a -G docker mlo-gpu-monitor
```

Build the docker images

```
MONITOR_UID=$(id -u mlo-gpu-monitor)
MONITOR_GID=$(getent group MLO-unit | awk -F: '{printf "%d\n", $3}')
docker build  --build-arg uid=$MONITOR_UID --build-arg gid=$MONITOR_GID -t mlo-nginx nginx
docker build  --build-arg uid=$MONITOR_UID --build-arg gid=$MONITOR_GID -t mlo-php php
```

Start docker compose

```
docker-compose up
```

