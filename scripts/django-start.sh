#!/usr/bin/env bash

function manage_app () {
    wait_for_mysql.py
    python manage.py makemigrations
    python manage.py migrate
    create_django_superuser.py
}

function start_development() {
    # use django runserver as development server here.
    manage_app
    python manage.py runserver 0.0.0.0:80
}

function start_production() {
    # use apache webserver for production here
    manage_app
    httpd-foreground
}

if [ ${PRODUCTION} == "true" ]; then
    # use production server
    start_production
else
    # use development server
    start_development
fi
