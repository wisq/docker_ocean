# Run `make <dev/prod> PULL=1` to upgrade docker images to latest.
ifeq ($(PULL),1)
	BUILD_ARGS += --pull
endif

deploy:
	docker context use ocean
	docker compose up --force-recreate --detach

.PHONY: deploy
