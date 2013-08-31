#!/bin/bash
# forked from https://gist.github.com/jpetazzo/5494158


DATADIR=/var/lib/postgresql/9.1/main
BINDIR=/usr/lib/postgresql/9.1/bin

mkdir -p $DATADIR
chown -R postgres /var/lib/postgresql

echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.1/main/pg_hba.conf

su postgres sh -c "$BINDIR/initdb $DATADIR"
su postgres sh -c "$BINDIR/postgres --single  -D $DATADIR  -c config_file=/etc/postgresql/9.1/main/postgresql.conf" <<< "CREATE USER root WITH SUPERUSER PASSWORD '$1';"
su postgres sh -c "$BINDIR/postgres           -D $DATADIR  -c config_file=/etc/postgresql/9.1/main/postgresql.conf  -c listen_addresses=*" 
