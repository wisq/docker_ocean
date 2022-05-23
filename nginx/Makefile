# Run `make <dev/prod> PULL=1` to upgrade docker images to latest.
ifeq ($(PULL),1)
	BUILD_ARGS += --pull
endif

all: nginx certbot

nginx: context
	docker context use ocean
	docker build -t nginx-release $(BUILD_ARGS) .
	docker compose up --force-recreate --detach nginx

certbot: context
	docker compose up --force-recreate certbot

context:
	docker context use ocean

.PHONY: all nginx certbot context
