FROM php:8.4.5-apache-bullseye

RUN apt-get update && apt-get install -y cron \
    git gnupg2 libicu-dev libpng-dev  libzip-dev \
    nano \
    pip \
    python3-requests \
    software-properties-common \
    unixodbc-dev \
    zip

RUN ln -sf /usr/bin/python3.9 /usr/bin/python

RUN pip install mysql-connector-python

# Install common ext
RUN docker-php-ext-install bcmath gd intl pcntl pdo pdo_mysql sockets zip

# Install pecl ext
RUN pecl install igbinary apcu

RUN echo extension=apcu.so | tee -a /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini

RUN echo extension=igbinary.so | tee -a /usr/local/etc/php/conf.d/docker-php-ext-igbinary.ini

COPY composer.phar /usr/local/bin/composer

COPY ./cron-entrypoint.sh /usr/local/bin/cron-entrypoint.sh

COPY ./worker-entrypoint.sh /usr/local/bin/worker-entrypoint.sh

RUN chmod 755 /usr/local/bin/cron-entrypoint.sh

COPY ./platform-jobs /etc/cron.d/platform-jobs

RUN chmod 0644 /etc/cron.d/platform-jobs

RUN crontab /etc/cron.d/platform-jobs

RUN touch /var/log/cron.log

RUN a2enmod rewrite
