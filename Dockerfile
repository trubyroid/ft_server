# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: truby <truby@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/24 16:17:38 by truby             #+#    #+#              #
#    Updated: 2021/04/25 01:17:26 by truby            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get -y install nginx wget vim mariadb-server php-mbstring php-zip php-gd php-mysql php7.3-fpm
RUN rm -Rf /etc/nginx/sites-enabled/default

COPY ./srcs/default /etc/nginx/sites-enabled/default
COPY ./srcs/change_on.sh /etc/nginx/sites-available/
COPY ./srcs/change_off.sh /etc/nginx/sites-available/
COPY ./srcs/server_init.sh /etc/ssl/

WORKDIR ./var/www/html/
RUN wget https://ru.wordpress.org/latest-ru_RU.tar.gz
RUN tar xvf latest-ru_RU.tar.gz && rm -rf latest-ru_RU.tar.gz
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz
RUN tar xvf phpMyAdmin-4.9.7-all-languages.tar.gz && rm -rf phpMyAdmin-4.9.7-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.7-all-languages phpmyadmin
COPY ./srcs/wp-config.php ./wordpress/

EXPOSE 80 443

WORKDIR ../../../etc/ssl/
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mykey.crt -subj "/C=RU/ST=Tatarstan/L=Kazan/O=school21/CN=truby"
CMD bash server_init.sh
