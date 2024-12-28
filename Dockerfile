FROM dunglas/frankenphp

# production|development
ARG PHP_INI_ENVIRONMENT=production
ARG USER=www-user

RUN cp $PHP_INI_DIR/php.ini-${PHP_INI_ENVIRONMENT} $PHP_INI_DIR/php.ini

RUN install-php-extensions \
	pdo_mysql \
	gd \
	intl \
	zip \
	opcache \
    bcmath \
    sockets \
    exif

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN \
	# Use "adduser -D ${USER}" for alpine based distros
	useradd ${USER}; \
	# Add additional capability to bind to port 80 and 443
	setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/frankenphp; \
	# Give write access to /data/caddy and /config/caddy
	chown -R ${USER}:${USER} /data/caddy && chown -R ${USER}:${USER} /config/caddy

USER ${USER}
