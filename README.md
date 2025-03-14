zabbix-docker/
├── .env                  File chứa biến môi trường
├── Dockerfile            Dockerfile để build Zabbix Server
├── docker-compose.yml    Docker Compose để quản lý các dịch vụ
├── mysql_data/           Thư mục chứa dữ liệu MySQL (được mount)

#docker-compose up -d
- move port
user: Admin
pass: zabbix
