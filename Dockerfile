FROM alpine:3.13
  
# Versões a serem instaladas
ENV S6_OVERLAY_VERSION "2.2.0.3"
ENV MAX_PHP_PROCESS=50
ENV NGINX_PROCESS="2"

# Instalando dependencias de SO e nginx
RUN apk add --no-cache nginx wget ca-certificates mysql-client msmtp \
					libssh2 curl libpng freetype libgcc libjpeg-turbo \ 
					libxml2 libstdc++ icu-libs libltdl libmcrypt 

# Instalando o S6 Overlay
RUN cd /tmp && \
	wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz && \
	tar xzf s6-overlay-amd64.tar.gz -C / && \
	rm s6-overlay-amd64.tar.gz;

# Instalando o PHP-FPM e dependencias
RUN apk add --no-cache \
            \
            php7 \
			php7-common \
			php7-fpm \
			php7-json \
            php7-xml \
			php7-pdo \
			php7-phar \
			php7-openssl \
            php7-pdo_mysql \
			php7-mysqli \
			php7-gd \
			php7-curl \
            php7-opcache \
			php7-ctype \
			php7-intl \
			php7-bcmath \
            php7-dom \
			php7-xmlreader \
			php7-xmlwriter \
			php7-tokenizer \
			php7-mbstring \
			php7-openssl \
			php7-pear \
			php7-mysqlnd \
			php7-mbstring \
			php7-fileinfo \
			php7-session \
            php7-ldap \
			php7-iconv \
			php7-zip \
			php7-apcu \
			php7-pecl-mcrypt \
			&& \
    ln -sf /dev/stdout /var/log/php-fpm-access.log && \
	ln -sf /dev/stderr /var/log/php-fpm.log && \
	rm -rf /etc/php7/php-fpm.d/*

# Instalando o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

COPY rootfs/ /etc/
COPY conf/php-fpm.conf /etc/php7/php-fpm.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

VOLUME ["/var/www/html"]

ENTRYPOINT ["/init"]