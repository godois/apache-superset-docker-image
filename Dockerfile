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
    SUPERSET_HOME=/home/superset \
	ENTRYPOINT_FOLDER=/opt/superset

RUN apt-get update && \
    apt-get install -y \
	build-essential \
	libssl-dev \ 
	libffi-dev \
	python-dev \
	python3-dev \
	python-pip \
	libsasl2-dev \
	libldap2-dev \
	libmysqlclient-dev


RUN pip install virtualenv

RUN sudo pip install --upgrade setuptools pip

RUN pip install superset

RUN pip install pymysql

RUN pip install mysqlclient

RUN fabmanager create-admin --app superset --username admin --password admin --firstname Admin --lastname "" --email admin@example.com

RUN superset db upgrade

RUN superset load_examples

RUN superset init

RUN mkdir -p $ENTRYPOINT_FOLDER

# Put the entrypoint file into the MongoDB directory
ADD run.sh $ENTRYPOINT_FOLDER/entry-point.sh

# Allows the Entrypoint file to execute as a shell 
RUN chmod 755 $ENTRYPOINT_FOLDER/entry-point.sh

# Expose the connection port to the host
EXPOSE 8088

# Set the entrypoint file
ENTRYPOINT ["/opt/superset/entry-point.sh"]