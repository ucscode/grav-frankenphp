GPM_FILE ?= ./gmp-dependencies.conf
DOCKER_EXEC=docker compose exec

.PHONY: install install-deps

build:
	docker compose build --pull --no-cache

down:
	docker compose down --remove-orphans

up: down
	docker compose up -d

logs:
	docker compose logs

ps:
	docker compose ps

install:
	$(DOCKER_EXEC) php bin/grav install
	@$(MAKE) install-deps

bash:
	$(DOCKER_EXEC) php bash

install-deps:
	./gmp-install $(GPM_FILE)


init: down build up install install-deps