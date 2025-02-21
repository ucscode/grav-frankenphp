init:
	@make down
	docker compose build --pull --no-cache
	@make up
	@make install

up:
	@make down
	docker compose up -d

down:
	docker compose down --remove-orphans

logs:
	docker compose logs

ps:
	docker compose ps

install:
	docker compose exec php bin/grav install
	docker compose exec php bin/gpm install admin --no-interaction
	docker compose exec php bin/gpm install learn2-git-sync --no-interaction

bash:
	docker compose exec php bash