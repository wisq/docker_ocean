# Run `make <target> PULL=1` to upgrade docker images to latest.
ifeq ($(PULL),1)
	BUILD_ARGS += --pull
endif

all: nginx certbot

nginx: context
	docker compose up $(UP_ARGS) --build --detach nginx

certbot: context
	docker compose up $(UP_ARGS) certbot

context:
	docker context use ocean

.PHONY: all nginx certbot context
