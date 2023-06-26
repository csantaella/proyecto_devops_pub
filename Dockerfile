FROM nginx:latest
COPY srcweb/ var/www/html
COPY default.conf: /etc/nginx/conf.d/default.conf
