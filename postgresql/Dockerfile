# PostgreSQL 9.6 with custom table for Tomcat session replication testing
FROM postgres:9.6
LABEL maintainer="ted@opub.com"

# custom setup file to create table that stores sessions
COPY setup.sql /docker-entrypoint-initdb.d/setup.sql
