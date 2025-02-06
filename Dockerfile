# Dockerfile
FROM ubuntu:20.04

# Thiết lập môi trường để không có các prompt trong quá trình cài đặt
ENV DEBIAN_FRONTEND=noninteractive

# Cập nhật và cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    nginx \
    php-fpm \
    php-mysql \
    php-gd \
    php-mbstring \
    php-xml \
    php-zip \
    curl \
    unzip \
    mariadb-client \
    supervisor

# Cài đặt WordPress
RUN curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/wordpress.tar.gz

# Cài đặt quyền truy cập cho thư mục WordPress
RUN chown -R www-data:www-data /var/www/html

# Copy cấu hình Nginx và PHP-FPM
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Cài đặt Supervisor để quản lý PHP-FPM và Nginx
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 80

# Khởi động Nginx và PHP-FPM thông qua Supervisor
CMD ["/usr/bin/supervisord"]
