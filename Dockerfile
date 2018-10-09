FROM php:apache

# We install and enable php-gddd, mod_rewrite
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        wget \
        zip \
        unzip && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
    a2enmod rewrite

# Copy app content
COPY . /var/www/html

# Copy start script
RUN mv /var/www/html/contrib/docker/entrypoint.sh / && \
    rm -r /var/www/html/contrib

VOLUME /var/www/html/data

CMD /entrypoint.sh
