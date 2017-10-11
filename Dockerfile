############################################################
# Dockerfile to build ApacheSuperset Dashboards 
# Based on baseImage
############################################################

# Set the base image to ubuntu:trusty
FROM ubuntu:trusty

# File Author / Maintainer
MAINTAINER Marcio Godoi <souzagodoi@gmail.com>

USER root

# Superset version
ARG SUPERSET_VERSION=0.20.3

# Configure environment
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONPATH=/etc/superset:$PYTHONPATH \
    SUPERSET_VERSION=${SUPERSET_VERSION} \
    SUPERSET_HOME=/home/superset

RUN apt-get update && \
    apt-get install -y \
	build-essential \
	libssl-dev \ 
	libffi-dev \
	python-dev \
	python-pip \
	libsasl2-dev \
	libldap2-dev

RUN pip install virtualenv

RUN sudo pip install --upgrade setuptools pip

RUN pip install superset

#RUN fabmanager create-admin --app superset

#superset db upgrade

#superset load_examples

#superset init

#superset runserver

#sudo apt-get install python-dev python3-dev
#sudo apt-get install libmysqlclient-dev
#pip install pymysql
#pip install mysqlclient


#http://54.173.173.213:8088

#mysql://newcoreapi:App2017Jupiter!@187.17.122.82:3306/newcore_staging
#mysql://root:123@localhost:3306/newcore_test


# Download Mongodb binary file and extract it to a folder
#RUN wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1404-3.4.2.tgz -P /tmp/mongodb && \
#  tar -xvzf /tmp/mongodb/mongodb-linux-x86_64-ubuntu1404-3.4.2.tgz -C /tmp/mongodb && \
#  mv /tmp/mongodb/mongodb-linux-x86_64-ubuntu1404-3.4.2 /usr/local/mongodb-3.4.2 && \
#  rm -rf /tmp/mongodb

# Creates directory used to store the data files
#RUN mkdir -p /opt/mongodb/data

# Creates directory used to store the log files
#RUN mkdir -p /opt/mongodb/log

# Set an environment variable with a mongodb root directory
#ENV MONGOPATH /usr/local/mongodb-3.4.2

# Add to a mongodb root directory the config file
#ADD mongod.yaml $MONGOPATH

# This init-standalone.js file is used to setup the admin user at the moment to startup the container
#ADD init-standalone.js $MONGOPATH

# Put the entrypoint file into the MongoDB directory
#ADD run.sh $MONGOPATH/bin/entry-point.sh

# Allows the Entrypoint file to execute as a shell 
#RUN chmod 755 $MONGOPATH/bin/entry-point.sh

# Expose the connection port to the host
#EXPOSE 27017

# Expose the rest port to the host
#EXPOSE 28017

# Set the entrypoint file
#ENTRYPOINT ["/usr/local/mongodb-3.4.2/bin/entry-point.sh"]