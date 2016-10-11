#
# This will install and configure Postgresql Database version 9.3 for SFA Registry service 
#

FROM ubuntu:14.04
MAINTAINER Radomir Klacza <radomir.klacza@lip6.fr>

# Install PostgreSQL
RUN apt-get update && apt-get -y install -y postgresql-9.3 postgresql-client-9.3

# Run the rest of the commands as the postgres user
USER postgres

RUN echo '' > /etc/postgresql/9.3/main/pg_hba.conf 
RUN echo 'local all all trust' >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "host all  all    0.0.0.0/0  trust" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Configure PostgreSQL 
RUN service postgresql start && createuser -U postgres -d pgdbuser --no-superuser --no-createrole && createdb -U postgres -O pgdbuser -E utf8 -T template0 sfa
RUN service postgresql start && psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';"
# Update PostgreSQL - TODO: This needs to be reviewed so it will not open PostgreSQL to whole world...  

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]
