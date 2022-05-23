FROM nginx:latest
RUN rm -r /etc/nginx/conf.d/
COPY common/ /etc/nginx/
COPY sites/ /etc/nginx/conf.d/
