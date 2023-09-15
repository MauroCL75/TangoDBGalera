#!/bin/sh

docker exec -u root -i tangodbgalera-north-1 mariadb --verbose mysql < del.sql
sleep 5
