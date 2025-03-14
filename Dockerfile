# Dockerfile for Zabbix Server
FROM zabbix/zabbix-server-mysql:latest

# Copy environment variables file
COPY .env /etc/zabbix/.env

# Chạy entrypoint mặc định
CMD ["/usr/sbin/zabbix_server", "--foreground"]
