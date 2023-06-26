FROM nginx:latest
COPY src/web/srcweb/ var/www/html
COPY src/web/default.conf /etc/nginx/conf.d/default.conf
