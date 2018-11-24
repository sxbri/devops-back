FROM php:7.1-apache-jessie

RUN echo 'deb http://packages.dotdeb.org jessie all'     >> /etc/apt/sources.list
RUN echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
RUN curl http://www.dotdeb.org/dotdeb.gpg > dotdeb.gpg
RUN apt-key add dotdeb.gpg

RUN apt-get update
RUN apt-get install -y git zip
RUN docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php && \
   mv composer.phar /usr/local/bin/composer

RUN a2enmod headers
RUN a2enmod rewrite

COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

RUN php -i