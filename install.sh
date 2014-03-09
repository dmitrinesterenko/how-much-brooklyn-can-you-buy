#!/bin/bash
bundle install
brew install posgres
#this may need proper fixed permissions to be installed 
initdb /data/postgresdb # just do this ONCE
pg_ctl -D /data/postgresdb start # many other options, e.g. logging, available here
psql postgres
#CREATE ROLE howmuchbrooklyncanyoubuy LOGIN
#  ENCRYPTED PASSWORD 'md5fb2bac6d6535f2c62f46546ff1d25d84'
#  SUPERUSER INHERIT CREATEDB NOCREATEROLE NOREPLICATION;
#CREATE DATABASE howmuchbrooklyncanyoubuy
#  WITH ENCODING='UTF8'
#       OWNER=howmuchbrooklyncanyoubuy
#       CONNECTION LIMIT=-1;
#CREATE DATABASE howmuchbrooklyncanyoubuy_test
#  WITH ENCODING='UTF8'
#       OWNER=howmuchbrooklyncanyoubuy
#       CONNECTION LIMIT=-1;
#CREATE DATABASE howmuchbrooklyncanyoubuy_development
#  WITH ENCODING='UTF8'
#       OWNER=howmuchbrooklyncanyoubuy
#       CONNECTION LIMIT=-1;
