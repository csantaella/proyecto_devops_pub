FROM nginx:latest

ADD src/ /var/www/html
WORKDIR /app	

# COPY ./default.conf /etc/nginx/conf.d/default.conf

ENV LISTEN_PORT=8000
ENV APP_HOST=app
ENV APP_PORT=9000

USER root
