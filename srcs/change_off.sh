#!bin/bash

sed -i "s|autoindex on;|autoindex off;|" "../sites-enabled/default"
service nginx restart
