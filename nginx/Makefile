# Run `make <dev/prod> PULL=1` to upgrade docker images to latest.
ifeq ($(PULL),1)
	BUILD_ARGS += --pull
endif

deploy:
	docker context use ocean
	docker build -t nginx-release $(BUILD_ARGS) .
	docker compose up --force-recreate --detach

certs:
	docker-compose run --rm --entrypoint " \
		certbot certonly \
			--webroot \
			-w /var/www/certbot \
			--email wisq@wisq.net \
			-d ismypowerbackyet.com \
			--rsa-key-size 4096 \
			--agree-tos \
			--no-eff-email \
		" certbot

.PHONY: deploy certs
