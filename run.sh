#!/bin/bash

if [ "$NEWINSTANCE" = true ];
then
    echo "Superset is creating an admin user... "
	fabmanager create-admin --app superset --username adm --password 123 --firstname Admin --lastname "" --email admin@example.com

    echo "Superset is upgrading databases... "
    superset db upgrade

    echo "Superset is loading examples... "
    superset load_examples

    echo "Superset init()... "
    superset init
	
fi
echo "Superset is starting the server... "
superset runserver



