# apache-superset-docker-image

A docker image to setup an Apache Superset instalation. https://superset.incubator.apache.org/

## What is Apache Superset?

Apache Superset (incubating) is a modern, enterprise-ready business intelligence web application.

> [https://superset.incubator.apache.org/](https://superset.incubator.apache.org/)


## Features

-   A rich set of data visualizations
-   An easy-to-use interface for exploring and visualizing data
-   Create and share dashboards
-   Enterprise-ready authentication with integration with major authentication providers (database, OpenID, LDAP, OAuth & REMOTE_USER through Flask AppBuilder)
-   An extensible, high-granularity security/permission model allowing intricate rules on who can access individual features and the dataset
-   A simple semantic layer, allowing users to control how data sources are displayed in the UI by defining which fields should show up in which drop-down and which aggregation and function metrics are made available to the user
-   Integration with most SQL-speaking RDBMS through SQLAlchemy
-   Deep integration with Druid.io


## How to use this image

### Setting up a simple container with basic params

```
$  docker run -d -it --name superset -p 8088:8088 -e NEWINSTANCE=true godois/apache-superset
```

### Setting up a container with volume

Important note: There are several ways to store data used by applications that run in Docker containers. I encourage users of this image to familiarize themselves with the options available, including:

-   Let Docker manage the storage of your database data  [by writing the database files to disk on the host system using its own internal volume management](https://docs.docker.com/engine/tutorials/dockervolumes/#adding-a-data-volume). This is the default and is easy and fairly transparent to the user. The downside is that the files may be hard to locate for tools and applications that run directly on the host system, i.e. outside containers.
-   Create a data directory on the host system (outside the container) and  [mount this to a directory visible from inside the container](https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-directory-as-a-data-volume). This places the database files in a known location on the host system, and makes it easy for tools and applications on the host system to access the files. The downside is that the user needs to make sure that the directory exists, and that e.g. directory permissions and other security mechanisms on the host system are set up correctly.

The Docker documentation is a good starting point for understanding the different storage options and variations, and there are multiple blogs and forum postings that discuss and give advice in this area. We will simply show the basic procedure here for the latter option above:

1.  Create a data directory on a suitable volume on your host system, e.g.  `/my/own/datadir`.
2.  Start your container superset container like this:
```
$  docker run -d -it --name superset -p 8088:8088 -v /my/own/datadir:/home/superset -e NEWINSTANCE=true godois/apache-superset
```
The `-v /my/own/datadir:/home/superset` part of the command mounts the `/my/own/datadir` directory from the underlying host system as `/home/superset` inside the container, where Apache Superset by default will write its data files.


### Useful commands

Kill all containers running and remove them:
```
$  docker kill $(docker ps -a -q) && docker rm $(docker ps -a -q)
```

Creating an isoleted network to run this container
```
$  docker network create --subnet=192.170.0.0/16 example-net
```

Build the image
```
$  docker build -t godois/apache-superset .
```

Exec a bash terminal connected to this container
```
$  docker exec -i -t superset /bin/bash
```

Visualize containers logs 
```
$  docker logs superset
```


