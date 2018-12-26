# Java-Spring-MySQL-Docker

This repo will showcase developing a Java Spring Tomcat webapp using MySQL, where the web server and database are run in separate Docker containers instead of on the host machine.

## Database

Follow these steps to build and run MySQL using the `docker-compose` command.

1.	Build the `database` image:

		docker-compose -f docker-compose-database.yml build
		
1.	Confirm it was built:

		docker image ls
		
	You should see somethig like this;
	
		REPOSITORY          TAG                 IMAGE ID            		CREATED             SIZE
		database            latest              4ee953e5ba7a        3 minutes ago       372MB

1.	Run a container in the background:

		docker-compose -f docker-compose-database.yml up -d

	At the start you will see some output like this:
	
		Creating MysqlContainer ... done
		
	And when you run a `docker ps` you will see it as well:
	
		CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                               NAMES
		178ad180d158        database            "docker-entrypoint.s…"   12 minutes ago      Up 12 minutes       0.0.0.0:3306->3306/tcp, 33060/tcp   MysqlContainer

	Notice how it our container is named `MysqlContainer`.  We configured this with the `container_name` field.
	
1.	We can use this name to log into our container and run some queries:

		docker exec -t -i MysqlContainer bash -c "mysql -u demouser -pdemopass"
		
1.	Shut down and remove our container like this:

		docker-compose -f docker-compose-database.yml down 

Navigate to the `database` directory and follow the instructions in the `README.md` file to build the MySQL image and run it by hand.

## Webserver

Follow these steps to build and run Tomcat using the `docker-compose` command.

1.	Build the `webserver` image:

		docker-compose -f docker-compose-webserver.yml build
		
1.	Confirm it was built:

		docker image ls
		
	You should see somethig like this;
	
		REPOSITORY          TAG                 IMAGE ID            		CREATED             SIZE
		webserver           latest              ad26e6ea1c66        12 seconds ago      463MB

1.	Run a container in the background:

		docker-compose -f docker-compose-webserver.yml up -d

	At the start you will see some output like this:
	
		Creating TomcatContainer ... done
		
	And when you run a `docker ps` you will see it as well:
	
		CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                               NAMES
		d127b6c4842a        webserver           "run.sh"            28 seconds ago      Up 27 seconds       0.0.0.0:8000->8000/tcp, 8080/tcp   TomcatContainer


	Notice how it our container is named `TomcatContainer`.  We configured this with the `container_name` field.

1.	We can use this unique name to log into our container and run some queries:

		docker exec -t -i TomcatContainer bash -c 'echo $CATALINA_HOME'
		
1.	Shut down and remove our container like this:

		docker-compose -f docker-compose-webserver.yml down 

Navigate to the `webserver` directory and follow the instructions in the `README.md` file to build the Tomcat image and run it by hand.

## Combined

The above steps work to create individual MySQL and Tomcat containers.  However, if you want to run a web application in the latter that is able to see the former, you will need to use `docker-compose` with a single configuration file.


1.	Build the `webserver` AND `database` images:

		docker-compose build
		
	By default, the `docker-compose.yml` file will be used.

		
1.	Confirm they were built:

		docker image ls
		
	You should see somethig like this;
	
		REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
		webserver           latest              9ad0c661faf9        5 seconds ago        475MB
		database            latest              ed73d93963d1        About a minute ago   372MB
		tomcat              7-jre8              a2605f20a75e        13 hours ago         475MB
		mysql               5.7                 ae6b78bedf88        5 weeks ago          372MB

1.	Run the containers in the background as before:

		docker-compose up -d
		
	Run a `docker ps` to confirm.  You should see something like this:
	
		CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                            NAMES
		4ed505289ed5        webserver           "run.sh"                 24 seconds ago      Up 22 seconds       0.0.0.0:8000->8000/tcp, 0.0.0.0:8080->8080/tcp   TomcatContainer
		93948c631b4c        database            "docker-entrypoint.s…"   24 seconds ago      Up 22 seconds       0.0.0.0:3306->3306/tcp, 33060/tcp                MysqlContainer
		
1.  Docker will automatically add DNS entries for "webserver" and "database".  Confirm the Tomcat container can see the MySql container by running the `ping database` command:

		docker exec -t -i TomcatContainer bash -c "ping database"
		
	You should see something like this:
	
		PING database (172.21.0.2) 56(84) bytes of data.
		64 bytes from MysqlContainer.java-spring-mysql-docker_default (172.21.0.2): icmp_seq=1 ttl=64 time=0.114 ms
		64 bytes from MysqlContainer.java-spring-mysql-docker_default (172.21.0.2): icmp_seq=2 ttl=64 time=0.167 ms
		64 bytes from MysqlContainer.java-spring-mysql-docker_default (172.21.0.2): icmp_seq=3 ttl=64 time=0.153 ms

Yay!  Now any application running in the Tomcat container can refer to the MySql container by the name "database".  For example, this might be the JDBC URL:

		jdbc:mysql://database:3306/hello-db?useSSL=false
	
Notice how we refer to the host as "database".
		


		

