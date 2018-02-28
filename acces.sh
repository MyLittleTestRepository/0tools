#!/bin/sh
find . -type f|xargs chmod 777
find . -type d|xargs chmod 777
find . -type f|xargs chown www-data:www-data
find . -type d|xargs chown www-data:www-data

