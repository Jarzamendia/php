# PHP

Docker Hub: https://hub.docker.com/r/jarzamendia/php

Imagem com PHP-FPM e Nginx

## Environment Variables

### MAX_PHP_PROCESS

A variável MAX_PHP_PROCESS é usada para definir o valor de pm.max_children. O valor padrão é 50.

Quanto maior o valor desta variável, mais memória o container usará em momentos de alto acesso. Porém mais acessos simultâneos ele aguentará.


### NGINX_PROCESS

A variável NGINX_PROCESS é usada para definir o valor de worker_processes. O valor padrão é 1. O ideal é 1 por CPU.

É importante lembrar que caso você utiliza limites de CPU, o valor de NGINX_PROCESS deve segui-lo.

## Modo de Uso

```shell
docker run -it -p 80:80 -v /path/to/www:/var/www/html \ 
                        -e MAX_PHP_PROCESS=25 \
                        -e NGINX_PROCESS=1 \
                        --cpus="1.0" \
                        --memory="300m" \
                        jarzamendia/php:7-fpm
```