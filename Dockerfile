FROM phpstorm/php-56-apache-xdebug-25

COPY ./conf/php.ini $PHP_INI_DIR/php.ini

RUN a2enmod rewrite

#PHP, extenções e outros pacote necessarios
RUN apt-get update && apt-get install -y --no-install-recommends libpng-dev libjpeg-dev libjpeg62-turbo libmcrypt4 libmcrypt-dev libcurl3-dev libxml2-dev libxslt-dev libicu-dev  && rm -rf /var/lib/apt/lists/*

RUN apt-get update  \
    && apt-get install -y zlib1g-dev \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/lib \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysql \
    && docker-php-ext-install exif \
    && apt-get purge --auto-remove -y libjpeg-dev libmcrypt-dev libcurl3-dev libxml2-dev libicu-dev \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql \
    && apt-get autoremove

# wkhtmltopdf:
RUN apt-get update && apt-get install -y libxrender1 libfontconfig1 libx11-dev libjpeg62 libxtst6 wget \
    && mkdir wkhtmltopdf_download \
    && cd wkhtmltopdf_download \
    && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb \
    && apt install ./wkhtmltox_0.12.5-1.stretch_amd64.deb -y \
    && cd .. \
    && rm -rf wkhtmltopdf_download

# xDebug
RUN echo 'zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so' >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9000" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey=docker" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \ 
    && echo "xdebug.idekey=\"PHPSTORM\"" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_enable=1" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host=docker.for.win.localhost" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini

ENV APACHE_DOCUMENT_ROOT=/var/www/html/intranet-sci
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf