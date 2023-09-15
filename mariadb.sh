#!/bin/sh

USER=tango
PASS=changeme
DB=tango
CONTAINER=tangodbgalera-north-1

docker exec -u root -it tangodbgalera-north-1 mariadb --verbose tango
