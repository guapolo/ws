FROM postgres:10.4-alpine

ARG DOCKER_DIR

ENV DB_USER=${DB_USER:-ws} \
    DB_NAME=${DB_USER:-ws} \
    PGDATA=/var/lib/postgresql/data/pg_data \
    STRUCTURE_SQL=/docker-entrypoint-initdb.d/structure.sequel

COPY ${DOCKER_DIR}/*.sh /docker-entrypoint-initdb.d/
# We change the name of the script so it doesn't get loaded on container first spin up.
COPY --chown=postgres:postgres db/structure.sql $STRUCTURE_SQL
COPY ${DOCKER_DIR}/docker-healthcheck /usr/local/bin/

RUN chmod u+x /usr/local/bin/docker-healthcheck; sync
HEALTHCHECK CMD ["docker-healthcheck"]