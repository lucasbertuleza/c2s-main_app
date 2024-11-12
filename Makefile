COMPOSE_CLI := $(shell if command -v docker-compose > /dev/null ; then echo "docker-compose" ; else echo "docker compose" ; fi)

build:
	@test -e .env || cp .env.example .env
	@$(COMPOSE_CLI) build

up:
	@$(COMPOSE_CLI) up -d
	@$(COMPOSE_CLI) ps -a --format "table {{.Name}}\t{{.Status}}"

down:
	@$(COMPOSE_CLI) down

devcontainer:
	@if [ ! "$$(which devcontainer)" ] ; then \
		echo "Instale a CLI do devcontainer a partir do VS Code:"; \
		echo "  F1 > Instalar a CLI do devcontainer"; exit 1 ; \
	fi
	@devcontainer open .
	@while [ ! $$(docker ps -q --filter name=main_app) ] ; do sleep 1 ; done
	@firefox --private-window 'https://localhost:3000' 1>/dev/null 2>&1 &

chown:
	@sudo chown -R $$USER:$$USER .

connect-root:
	$(COMPOSE_CLI) exec --user=root app ash

selenium:
	@if [ "$(shell docker ps -aq -f name=selenium)" ] ; then \
		$(COMPOSE_CLI) down selenium ; \
	else \
		$(COMPOSE_CLI) up -d selenium ; \
	fi

mailserver:
	@if [ "$(shell docker ps -aq -f name=mailserver)" ] ; then \
		$(COMPOSE_CLI) down mailserver ; \
	else \
		$(COMPOSE_CLI) up -d mailserver ; \
	fi

redisinsight:
	@if [ "$(shell docker ps -aq -f name=redisinsight)" ] ; then \
		$(COMPOSE_CLI) down redisinsight ; \
	else \
		$(COMPOSE_CLI) up -d redisinsight ; \
	fi

webdb:
	@if [ "$(shell docker ps -aq -f name=webdb)" ] ; then \
		$(COMPOSE_CLI) down webdb ; \
	else \
		$(COMPOSE_CLI) up -d webdb ; \
