COMPOSE = docker-compose
EXEC = docker exec -it 
HASURA_CONTAINER = $(shell docker ps -qf "name=graphql-engine")
DB_CONTAINER = $(shell docker ps -qf "name=postgres")

PG_DUMP = $(EXEC) $(DB_CONTAINER) pg_dump -d postgres -U postgres

PGADMIN_LOCAL_PORT = 8400


SSH_OPTIONS = $(JELASTIC_NODE_ID)-$(JELASTIC_USER_ID)@$(JELASTIC_SSH_HOST)
SSH = ssh $(SSH_OPTIONS)
SSH_TUNNEL = $(SSH) -N -L 

OPEN = explorer.exe
PORTAINER_REMOTE_URL=https://node63748-shopozor-quick-form.hidora.com:11134/

HASURA_CLI=hasura --admin-secret=$(HASURA_GRAPHQL_ADMIN_SECRET)
HASURA_REMOTE_CLI=$(HASURA_CLI) --endpoint=https://$(HOST) 

REMOTE_GRAPHQL_ENDPOINT=https://$(HOST)/v1/graphql

env:
	@echo 'set -a; source .env set +a' | clip.exe
env.%:
	@echo 'set -a; source .env.$* set +a' | clip.exe

pg-container:
	echo $(PG_CONTAINER)

db.dump:
	@$(PG_DUMP)

db.dump.public.data:
	@$(PG_DUMP) --data-only --schema=public
	

db.bash:
	$(EXEC)  $(DB_CONTAINER) sh 

up: 
	$(COMPOSE) up -d
down:
	$(COMPOSE) down
rm:
	$(COMPOSE) rm
hard-restart:
	make down && make rm && make up

ssh:
	$(SSH)

pgadmin.ssh-tunnel:
	@echo tunneling localhost:$(PGADMIN_LOCAL_PORT) to remote port $(PGADMIN_PORT)
	$(SSH_TUNNEL) $(PGADMIN_LOCAL_PORT):localhost:$(PGADMIN_PORT) &
tunnels: pgadmin.ssh-tunnel

open.portainer:
	$(OPEN) $(PORTAINER_REMOTE_URL)
open.pgadmin:
	$(OPEN) http://localhost:$(PGADMIN_LOCAL_PORT)
open.graphql-engine:
	$(OPEN) https://$(HOST)
clip.graphql-endpoint:
	@echo $(REMOTE_GRAPHQL_ENDPOINT)


alias.init:
	@echo alias hasura.remote="'$(HASURA_REMOTE_CLI)'" > .bash_aliases
	@echo alias hasura.local="'$(HASURA_CLI)'" >> .bash_aliases

alias.load:
	echo "source .bash_aliases" | clip.exe
hasura.switch.local:
hasura.switch.remote:
hasura.switch.%:
	echo "alias hasura='hasura.$*'" | clip.exe
hasura.restore:
	echo "alias hasura='hasura'" | clip.exe
