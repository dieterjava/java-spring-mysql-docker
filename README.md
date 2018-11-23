# Java-Spring-MySQL-Docker

This repo will showcase developing a Java Spring Tomcat webapp using MySQL, where the web server and database are run in separate Docker containers instead of on the host machine.

## Database

Navigate to the `database` directory and follow the instructions in the `README.md` file to build the MySQL image and run it by hand.

Follow these steps to build and run it using the `docker-compose` command.

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
	
		Recreating java-spring-mysql-docker_database_1 ... done
		
	And when you run a `docker ps` you will see it as well:
	
		CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                               NAMES
		178ad180d158        database            "docker-entrypoint.s…"   12 minutes ago      Up 12 minutes       0.0.0.0:3306->3306/tcp, 33060/tcp   java-spring-mysql-docker_database_1


	Notice how it prepended the working directory as and appended a number to the image name.  This is to ensure uniqueness.

1.	We can use this unique name to log into our container and run some queries:

		docker exec -t -i java-spring-mysql-docker_database_1 bash -c "mysql -u demouser -pdemopass"
		
1.	Shut down and remove our container like this:

		docker-compose -f docker-compose-database.yml down 

