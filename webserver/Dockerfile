# Base image.
FROM tomcat:7-jre8

# Copy the 'tomcat-users.xml' file to container.
COPY tomcat/tomcat-users.xml $CATALINA_HOME/conf/

# Copy the startup script to the container, make executable
COPY tomcat/run.sh $CATALINA_HOME/bin/run.sh
RUN chmod +x $CATALINA_HOME/bin/run.sh

# Call startup script.
CMD ["run.sh"]
