FROM php:7.1.2-apache 

ENV PACKAGES tzdata git zlib1g-dev mysql-client

ENV TZ America/Santiago

RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y --no-install-recommends $PACKAGES && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

RUN docker-php-ext-install pdo pdo_mysql zip && a2enmod rewrite && \
    curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

COPY /www /var/www/html

RUN chown -R $APACHE_RUN_USER:$APACHE_RUN_GROUP /var/www/html

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
