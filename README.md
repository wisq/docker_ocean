# docker_ocean

A collection of Docker configs and scripts to run my personal projects cluster.

The `ocean` name is because I deploy these to a [DigitalOcean Docker](https://marketplace.digitalocean.com/apps/docker) "one-click" droplet.  Aside from setting up some custom firewall rules, I've been able to leave that host mostly untouched, just running these scripts from my laptop to remotely launch containers.

I've made these public so others can use them as examples.

## nginx

Builds and launches an [nginx](https://hub.docker.com/_/nginx) container with a custom configuration.

Also launches a [certbot](https://hub.docker.com/r/certbot/certbot) container that will issue and renew certificates as required.  **This requires that the included [`renew.sh`](nginx/renew.sh) script be run regularly;** see that script for details.

This is loosely based off [this guide](https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71) by Philipp, but with some reworking.  The `nginx` container has its configuration baked in rather than on a shared volume, and the `certbot` container only runs when renewing.  In exchange, the Docker server just needs to run a simple cronjob on a regular basis.

This creates a network named `nginx`.  To reverse-proxy to another Docker-based web application, make sure it's on that network, and then just `proxy_pass http://<container-name>:<port>`.

### Adding a new HTTPS domain

Adding a new domain is a three-step process:

 1. In your new `sites/x.conf` file, add the `listen 80` block.  (This must include the `location /.well-known/acme-challenge/` block.)
 2. Run `make` which will build and deploy the nginx config, and then launch certbot to issue your new cert.
 3. If all goes well, now add the `listen 443` block to your site config (pointing at your newly issued certs), and run `make nginx` again to deploy it.

While it's not a one-step script like Philipp's approach, this setup requires no direct interaction with the certbot data directories, which means I can run it remotely (e.g. on my laptop) rather than directly on the Docker server.  It also avoids the (to my eye, ugly) `while ... sleep` loops.

*(Yes, I'm aware Philipp has a [newer post using Traefik](https://pentacent.medium.com/lets-encrypt-for-your-docker-app-in-less-than-5-minutes-24e5b38ca40b), but I'm much more comfortable with a simple nginx setup.  Call me old-fashioned I guess.)*

## postgres

Launches a [postgis](https://registry.hub.docker.com/r/postgis/postgis/) container with a persistent data store.

This requires a `.env.postgres` file be created, containing `POSTGRES_PASSWORD=<some password>`.  You'll need to use this password to connect as the `postgres` user.

This originally used the [postgres](https://hub.docker.com/_/postgres) Docker image, and if you don't need GIS functionality, you can easily switch to that image instead, without needing to change anything else in the config.

This creates a network named `postgres`.  To allow another Docker-based application to access the database, make sure it's on that network, and then use the Postgres container's name as your database hostname.
