FROM php:7.2-fpm

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    apt-get update -y && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash && \
    apt-get update && apt-get install -y \
    build-essential \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    iputils-ping \
    net-tools \
    libpng-dev \
    libssl-dev \
    apt-utils \
    cron \
    vim \
    nano \
    curl \
    wget \
    git \
  #  nodejs \
    libxml2-dev \
    gnupg 
  #uncoment if you need npm and add it to the chain
    #curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    #apt-get install -y npm


# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
    mysqli \
    pdo \
    pdo_mysql \
    mysqli \
    mbstring \
    tokenizer \
    intl \
    xml \
    ctype \
    json \
    zip \
    gd
#Adding debuger
RUN yes | pecl install xdebug \
    && echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey = PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_host=laravel_local_forge" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/xdebug.ini

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents, we dont use this, but just in case we ever need it. 
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www-data:www-data . /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
CMD ["php-fpm"]
EXPOSE 9000
