GPM_FILE=gpm-dependencies.txt
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
	@echo "Installing dependencies from $(GPM_FILE)..."
	@while IFS= read -r dependency; do \
		if [ -n "$$dependency" ] && [ "$$(printf '%s' "$$dependency" | cut -c1)" != "#" ]; then \
			echo "Installing $$dependency..."; \
			$(DOCKER_EXEC) -T php bin/gpm install "$$dependency" --no-interaction; \
		fi \
	done < $(GPM_FILE)
	@echo "All dependencies installed."


init: down build up install install-deps