COMPOSE = docker-compose
EXEC = docker exec -it 
HASURA_CONTAINER = $(shell docker ps -qf "name=graphql-engine")
DB_CONTAINER = $(shell docker ps -qf "name=postgres")


# Postgres utilities
PG_DUMP = $(EXEC) $(DB_CONTAINER) pg_dump -d $(POSTGRES_DB) -U $(POSTGRES_USER) 
PG_RESTORE = $(EXEC) $(DB_CONTAINER) pg_restore -d $(POSTGRES_DB) -U $(POSTGRES_USER) 
PSQL = $(EXEC) $(DB_CONTAINER) psql -d $(POSTGRES_DB) -U $(POSTGRES_USER) 

PGADMIN_LOCAL_PORT = 8400


SSH_OPTIONS = $(JELASTIC_NODE_ID)-$(JELASTIC_USER_ID)@$(JELASTIC_SSH_HOST)
SSH = ssh $(SSH_OPTIONS)
SSH_TUNNEL = $(SSH) -N -L 

CLIP = clip.exe
OPEN = explorer.exe
PORTAINER_REMOTE_URL=https://node63748-shopozor-quick-form.hidora.com:11134/

HASURA_CLI=hasura --admin-secret=$(HASURA_GRAPHQL_ADMIN_SECRET)
HASURA_REMOTE_CLI=$(HASURA_CLI) --endpoint=https://$(HOST) 

REMOTE_GRAPHQL_ENDPOINT=https://$(HOST)/v1/graphql

env:
	@echo 'set -a; source .env set +a' | $(CLIP)
env.%:
	@echo 'set -a; source .env.$* set +a' | $(CLIP)

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
copy.graphql-endpoint:
	@echo $(REMOTE_GRAPHQL_ENDPOINT) | $(CLIP)


alias.init:
	@echo alias hasura.remote="'$(HASURA_REMOTE_CLI)'" > .bash_aliases
	@echo alias hasura.local="'$(HASURA_CLI)'" >> .bash_aliases
	@echo alias db.dump="'docker exec $(docker ps -qf "name=postgres") pg_dump -d $(POSTGRES_DB) -U $(POSTGRES_USER) --data --schema=public'" >> .bash_aliases

alias.load:
	echo "source .bash_aliases" | $(CLIP)
hasura.switch.local:
hasura.switch.remote:
hasura.switch.%:
	echo "alias hasura='hasura.$*'" | $(CLIP)
hasura.restore:
	echo "alias hasura='hasura'" | $(CLIP)

jwt.generate:
	pipenv run python scripts/generate_jwt.py 1 
copy.jwt.generate:
	@pipenv run python scripts/generate_jwt.py 1  | $(CLIP)

