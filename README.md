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
