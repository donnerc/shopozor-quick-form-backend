COMPOSE = docker-compose
EXEC = docker exec -it 
HASURA_CONTAINER = $(shell docker ps -qf "name=graphql-engine")
DB_CONTAINER = $(shell docker ps -qf "name=postgres")

PG_DUMP = $(EXEC) $(DB_CONTAINER) pg_dump -d postgres -U postgres

PGADMIN_LOCAL_PORT = 8400


SSH_OPTIONS = 63748-3210@gate.hidora.com -p 3022
SSH = ssh $(SSH_OPTIONS)
SSH_TUNNEL = $(SSH) -N -L 

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
	$(SSH_TUNNEL) $(PGADMIN_LOCAL_PORT):localhost:$(PGADMIN_PORT)