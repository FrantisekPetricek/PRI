FROM php:8.2-apache

# upgrade & install basic tools
RUN apt update && apt upgrade -y
RUN apt install -y mc vim nano less

# install libxml2 and libxslt (pro dom a xsl rozšíření)
RUN apt install -y libxml2-dev libxslt1-dev

# install PHP extensions
RUN docker-php-ext-install dom xsl mysqli

# PHP debugger – xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN cat <<EOF >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
xdebug.mode=debug
xdebug.idekey=docker
xdebug.start_with_request=yes
xdebug.client_host=host.docker.internal
xdebug.client_port=9003
EOF

# Apache configuration
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod headers rewrite

# working directory
WORKDIR /var/www
