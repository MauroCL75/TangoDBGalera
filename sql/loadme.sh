#!/bin/sh

USER=tango
PASS=changeme
DB=tango
CONTAINER=tangodbgalera-north-1

lbip=`docker inspect   -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER`

docker exec -u root -i tangodbgalera-north-1 mariadb --verbose mysql < mkuser.sql
sleep 20
mariadb -u $USER -p$PASS -h $lbip $DB  << EOSQL
source create_db.sql;
source create_db_tables.sql;
source update_db.sql;
source update_db_from_5_to_9.3.4.sql;
exit
EOSQL
