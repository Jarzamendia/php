#!/usr/bin/with-contenv sh

sed -i "s|worker_processes 1|worker_processes $NGINX_PROCESS|" /etc/nginx/nginx.conf

sed -i "s|/var/www/html/|$NGINX_HOME|" /etc/nginx/nginx.conf 