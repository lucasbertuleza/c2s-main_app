warning_local_host := Você não está no container!
warning_docker_host := Você está no container!
JENKINS_PUBLIC_KEY := docker exec jenkins-server ash -c "cat ~/.ssh/jenkins_agent_key.pub"

devcontainer:
	@if [ ! "$$(which devcontainer)" ] ; then \
		echo "Instale a CLI do devcontainer a partir do VS Code:"; \
		echo "  F1 > Instalar a CLI do devcontainer"; exit 1 ; \
	fi
	@devcontainer open .
	@while [ ! $$(docker ps -q --filter name=flickscape_app) ] ; do sleep 1 ; done
	@firefox --private-window 'https://localhost:3000' 1>/dev/null 2>&1 &

chown:
ifdef RAILS_ENV
	chown -R $$USER:$$USER .
else
	sudo chown -R $$USER:$$USER .
endif

connect-root:
ifdef RAILS_ENV
	@echo $(warning_docker_host)
else
	docker compose exec --user=root app ash
endif

down:
ifdef RAILS_ENV
	@echo $(warning_docker_host)
else
	docker compose down
endif

selenium:
ifdef RAILS_ENV
	@echo $(warning_docker_host)
else
	@if [ "$(shell docker ps -aq -f name=selenium)" ] ; then \
		docker compose down selenium ; \
	else \
		docker compose up -d selenium ; \
	fi
endif

mailserver:
ifdef RAILS_ENV
	@echo $(warning_docker_host)
else
	@if [ "$(shell docker ps -aq -f name=mailserver)" ] ; then \
		docker compose down mailserver ; \
	else \
		docker compose up -d mailserver ; \
	fi
endif

redisinsight:
ifdef RAILS_ENV
	@echo $(warning_docker_host)
else
	@if [ "$(shell docker ps -aq -f name=redisinsight)" ] ; then \
		docker compose down redisinsight ; \
	else \
		docker compose up -d redisinsight ; \
	fi
endif

webdb:
ifdef RAILS_ENV
	@echo $(warning_docker_host)
else
	@if [ "$(shell docker ps -aq -f name=webdb)" ] ; then \
		docker compose down webdb ; \
	else \
		docker compose up -d webdb ; \
	fi
endif

jenkins-build:
	@docker build --target docker --tag flickscape/jenkins-docker \
		--file docker/jenkins.Dockerfile
	@docker build --target server --tag flickscape/jenkins-server \
		--file docker/jenkins.Dockerfile .
	@docker build --target agent --tag flickscape/jenkins-agent \
		--build-arg DOCKER_VERSION=$$(docker --version | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+") \
		--build-arg DOCKER_COMPOSE_VERSION=$$(docker compose version | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+") \
		--build-arg DOCKER_BUILDX_VERSION=$$(docker buildx version | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+") \
		--file docker/jenkins.Dockerfile .
	@if [ ! "$$(docker network ls -q -f name=jenkins)" ] ; then \
		docker network create jenkins ; \
	fi

docker-client-key:
	@docker exec jenkins-docker ash -c "cat /certs/client/key.pem" | xclip -rmlastnl -sel copy

docker-client-cert:
	@docker exec jenkins-docker ash -c "cat /certs/client/cert.pem" | xclip -rmlastnl -sel copy

docker-server-ca-cert:
	@docker exec jenkins-docker ash -c "cat /certs/client/ca.pem" | xclip -rmlastnl -sel copy

jenkins-password:
	@docker exec jenkins-server ash -c "cat ~/secrets/initialAdminPassword" | xclip -rmlastnl -sel copy

jenkins-private-key:
	@docker exec jenkins-server ash -c "cat ~/.ssh/jenkins_agent_key" | xclip -rmlastnl -sel copy

jenkins-public-key:
	@$(JENKINS_PUBLIC_KEY) | xclip -rmlastnl -sel copy

jenkins-up:
	@docker run --name jenkins-docker --rm --detach --privileged \
		--network jenkins --network-alias docker \
		--volume jenkins-docker-certs:/certs/client \
		--volume jenkins-agents-data:/home/jenkins \
		flickscape/jenkins-docker --storage-driver overlay2
	@docker run --name jenkins-server --restart=always --detach \
		--network jenkins --publish 8080:8080 \
		--mount type=bind,source=.,target=/flickscape \
		--volume jenkins-data:/var/jenkins_home \
		flickscape/jenkins-server
	@while [ ! "$$(docker ps -q --filter name=jenkins-server --filter status=running)" ] ; do sleep 2 ; done
	@docker exec jenkins-server ash -c 'test -f ~/.ssh/jenkins_agent_key || ssh-keygen -q -N "" -f ~/.ssh/jenkins_agent_key'
	@for num in 1 2 ; do \
		docker run --name jenkins-agent$$num --rm --detach \
			--network jenkins --network-alias agent$$num \
			--env JENKINS_AGENT_SSH_PUBKEY="$$($(JENKINS_PUBLIC_KEY))" \
			--env AGENT_WORKDIR=/home/jenkins/agent$$num \
			--mount source=jenkins-agents-data,target=/home/jenkins/agent$$num,volume-subpath=agent$$num \
			--volume jenkins-docker-certs:/certs/client:ro \
			flickscape/jenkins-agent ; \
	done

jenkins-down:
	@docker stop jenkins-docker jenkins-server jenkins-agent1 jenkins-agent2
	@docker rm "$$(docker ps -aq --filter name=jenkins)"