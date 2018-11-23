# The base image.
# See more at image documentation:
# https://hub.docker.com/_/mysql/
FROM mysql:5.7

# Copy the database initialize script.
COPY ./docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/

# Not defaulted for security reasons!
# ENV MYSQL_ROOT_PASSWORD=my-secret-pw

# Default value for database name, user with superuser access.
ENV MYSQL_DATABASE=demodb
ENV MYSQL_USER=demouser
ENV MYSQL_PASSWORD=demopass
