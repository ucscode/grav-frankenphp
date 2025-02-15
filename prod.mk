DOCKER_COMPOSE_PROD := docker compose -f compose.yaml -f compose.prod.yaml
THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
MAKE_CMD = $(MAKE) -f $(THIS_MAKEFILE)

init:
	$(MAKE_CMD) down
	$(DOCKER_COMPOSE_PROD) build --pull --no-cache
	$(MAKE_CMD) up
	$(MAKE_CMD) install

up:
	$(MAKE_CMD) down
	$(DOCKER_COMPOSE_PROD) up -d

down:
	$(DOCKER_COMPOSE_PROD) down --remove-orphans

logs:
	$(DOCKER_COMPOSE_PROD) logs

ps:
	$(DOCKER_COMPOSE_PROD) ps

install:
	$(DOCKER_COMPOSE_PROD) exec php bin/grav install
	$(DOCKER_COMPOSE_PROD) exec php ./build/gpm.run

bash:
	$(DOCKER_COMPOSE_PROD) exec php bash