FROM nginx:1.14-alpine


COPY conf/nginx.conf /etc/nginx/conf.d/default.conf