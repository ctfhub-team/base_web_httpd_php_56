FROM php:5.6-apache

LABEL Organization="CTFHUB" Author="Virink <virink@outlook.com>"

ENV TZ=Asia/Shanghai

COPY _files /tmp/

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone; \
    sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt-get update -y; apt-get install -y net-tools wget; \
    # apt-get install -y vim net-tools htop wget; \
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
