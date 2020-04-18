FROM php:5.6-apache

LABEL Organization="CTFHUB" Author="Virink <virink@outlook.com>"

COPY _files /tmp/

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 'd/security.debian.org/g' /etc/apt/sources.list \
    && apt update -y; \
    # configure file
    mv /tmp/flag.sh /flag.sh \
    && mv /tmp/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint \
    && echo '<?php phpinfo();' > /var/www/html/index.php \
    && chown -R www-data:www-data /var/www/html \
    && chmod +x /usr/local/bin/docker-php-entrypoint \
    && mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    # clear
    && rm -rf /tmp/*

WORKDIR /var/www/html

EXPOSE 80
