all: nginx postgres

nginx:
	$(MAKE) -C nginx

postgres:
	$(MAKE) -C postgres

.PHONY: all nginx postgres
