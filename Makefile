.PHONY: prepare primary primary lb mkUser mktangodb
current_dir = $(shell pwd| sed "s+/+\/+g" )

prep:
	@echo Running prepare 
	./cleanup.sh
	cat docker-compose.tpl |  sed 's+HERE+$(current_dir)+g' > docker-compose.yml
	
primary: 
	@echo starting north
	docker-compose up -d north
	@echo edit docker-compose.yml if you plan to restart it
	@echo waiting for init
	@sleep 20

rest: 
	@echo starting the rest of containers
	docker-compose up -d south west east
	sleep 10

lb:
	@echo starting the load balancer
	docker-compose up -d haplb

mktangodb:
	cd ./sql; pwd; ./loadme.sh

databaseds:
	@echo starting databaseds
	docker-compose up -d databaseds

cleanup:
	cd sql;./del.sh

stop:
	docker-compose down

all: prep primary rest lb mktangodb databaseds
