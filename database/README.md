# MySQL database container to run on Docker

Follow these steps to build a MySQL database, run it in a container, and initialize a table and user.

1.  Build the image from the `Dockerfile` in this directory, and tag it with the name `mysqlondocker`:

		docker image build -t mysqlondocker .
        
1.  Confirm the image was built:

		docker image ls

	You should see something like this:
	
	```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
mysqlondocker       latest              2eda634b58f2        22 seconds ago      372MB
mysql               5.7                 ae6b78bedf88        7 days ago          372MB
```

	Docker pulled the `mysql` image and then made ours from it according to the steps in the `Dockerfile`.
	
1. Run the container like this:
		
		docker container run -e "MYSQL_ROOT_PASSWORD=my-secret-pw" -p 3306:3306 -d mysqlondocker
	
	Notice a few things:
	* We use the `-e` flag to specify the environment variable for the root password, which is required by the image.  (TODO: Make more secure.)
	* We use the `-p` flag to map port 3306 on our host machine to port 3306 in the container.  Now, we can log into our container and run queries.
	* We use th `-d` flag to run in "detached" mode (i.e. in the background).

1.  Confirm the container is running:

		docker ps -f "ancestor=mysqlondocker"
		
	You should see `tomcatondocker` listed.

1. Let's extract the container id because that is needed to connect directly to it.  Set this variable in your shell for use later on:

		container_id=$(docker ps -f "ancestor=mysqlondocker" -q)
		
1.  Now, let's connect to our MySQL instance:

		docker exec -t -i ${container_id} bash -c "mysql -udemouser -pdemopass"

	Switch to the database that was created for us and see if our table is there:
	
	```sql
		mysql> use demodb;
		Reading table information for completion of table and column names
		You can turn off this feature to get a quicker startup with -A
		
		Database changed
		mysql> show tables;
		+------------------+
		| Tables_in_demodb |
		+------------------+
		| user             |
		+------------------+
		1 row in set (0.00 sec)
```
		
	Yay!  The table was created as specified.

1.  To shut down and remove the container, type these commands:

		docker container stop ${container_id}
		docker container rm ${container_id} 













