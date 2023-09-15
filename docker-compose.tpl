version: '3.0'

services:
  north:
    hostname: north
    image: docker.io/bitnami/mariadb-galera:11.0
    volumes:
      - HERE/storage/1:/bitnami/mariadb
    environment:
      # ALLOW_EMPTY_PASSWORD is recommended only for development.
      - ALLOW_EMPTY_PASSWORD=yes
      - MARIADB_USER=haproxy
      - MARIADB_GALERA_CLUSTER_ADDRESS=gcomm://
      - MARIADB_GALERA_CLUSTER_BOOTSTRAP=yes
    healthcheck:
      test: ['CMD', '/opt/bitnami/scripts/mariadb-galera/healthcheck.sh']
      interval: 15s
      timeout: 5s
      retries: 6

  south:
    hostname: south
    image: docker.io/bitnami/mariadb-galera:11.0
    volumes:
      - HERE/storage/2:/bitnami/mariadb
    environment:
      # ALLOW_EMPTY_PASSWORD is recommended only for development.
      - ALLOW_EMPTY_PASSWORD=yes
      - MARIADB_GALERA_CLUSTER_ADDRESS=gcomm://tangodbgalera-north-1
    healthcheck:
      test: ['CMD', '/opt/bitnami/scripts/mariadb-galera/healthcheck.sh']
      interval: 15s
      timeout: 5s
      retries: 6

  east:
    hostname: east
    image: docker.io/bitnami/mariadb-galera:11.0
    volumes:
      - HERE/storage/3:/bitnami/mariadb
    environment:
      # ALLOW_EMPTY_PASSWORD is recommended only for development.
      - ALLOW_EMPTY_PASSWORD=yes
      - MARIADB_GALERA_CLUSTER_ADDRESS=gcomm://tangodbgalera-north-1
      #- MARIADB_GALERA_CLUSTER_ADDRESS=gcomm://north_1
    healthcheck:
      test: ['CMD', '/opt/bitnami/scripts/mariadb-galera/healthcheck.sh']
      interval: 15s
      timeout: 5s
      retries: 6

  west:
    hostname: west
    image: docker.io/bitnami/mariadb-galera:11.0
    volumes:
      - HERE/storage/4:/bitnami/mariadb
    environment:
      # ALLOW_EMPTY_PASSWORD is recommended only for development.
      - ALLOW_EMPTY_PASSWORD=yes
      - MARIADB_GALERA_CLUSTER_ADDRESS=gcomm://tangodbgalera-north-1
      #- MARIADB_GALERA_CLUSTER_ADDRESS=gcomm://north_1
    healthcheck:
      test: ['CMD', '/opt/bitnami/scripts/mariadb-galera/healthcheck.sh']
      interval: 15s
      timeout: 5s
      retries: 6

  haplb:
    hostname: haplb
    image: haproxy:2.8-alpine
    volumes:
      - HERE/haproxy:/usr/local/etc/haproxy:ro

  databaseds:
    image: artefact.skao.int/ska-tango-images-tango-libtango:9.3.6
    environment:
      - MYSQL_USER=tango
      - MYSQL_PASSWORD=changeme
      - MYSQL_HOST=tangodbgalera-haplb-1:3306
    command:
      - /usr/local/bin/DataBaseds
      - "2"
      - -v4
      - -ORBendPoint
      - giop:tcp:0.0.0.0:10000
