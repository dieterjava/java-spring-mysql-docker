FROM mysql:5.7

# Copy the database initialize script.
# Contents of '/docker-entrypoint-initdb.d' are run on mysqld startup.
# https://docs.docker.com/samples/library/mysql/#docker-secrets
COPY ./docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/

# Default values for database name.
ENV MYSQL_DATABASE=demodb

# Not defaulted for security reasons!
# ENV MYSQL_ROOT_PASSWORD=my-secret-pw

# See more at image documentation:
# https://hub.docker.com/_/mysql/
# ENV MYSQL_USER=username
# ENV MYSQL_PASSWORD=password
