FROM dunglas/frankenphp:1.3.6-php8.4.2-bookworm

# production|development
ARG PHP_INI_ENVIRONMENT=production
ARG USER=www-user

RUN cp $PHP_INI_DIR/php.ini-${PHP_INI_ENVIRONMENT} $PHP_INI_DIR/php.ini

RUN apt-get update && apt-get install -y --no-install-recommends \
	acl \
	file \
	gettext \
	git \
	autoconf \
    libssl-dev \
    g++ \
    make \
    libpcre3-dev \
    libicu-dev \
	jq \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN set -eux; \
	install-php-extensions \
		@composer \
		gd \
		apcu \
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
