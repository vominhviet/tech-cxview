BUILD MONITOR PROMETHEUS GRAFANA BY DOCKER COMPOSE

Step 1 :

git clone git@github.com:vindevops99/Monitor.git

step 2:

cd Monitor

docker compose up -d && docker compose logs -f (cmd start 4 container prometheus + grafana + alertmanager + node exporter )
