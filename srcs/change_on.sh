#!bin/bash

sed -i "s|autoindex off;|autoindex on;|" "../sites-enabled/default"
service nginx restart
