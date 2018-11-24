#!/bin/sh

# Start Tomcat in foreground under JPDA debugger.
exec ${CATALINA_HOME}/bin/catalina.sh jpda run
