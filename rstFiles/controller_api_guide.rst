.. _monitor_thread_api:

RAN Tester UE Controller API Guide
==================================

What is the Controller API for?
-------------------------------

The controller API exists to allow for the creation and monitoring of
custom docker containers. A Python thread, which we will refer to as a
**worker thread** is started by the controller’s main process, which
should control and report one docker container, containing any desired
software. The worker thread should have certain methods that the
controller expects, which we will discuss in the following document.

The \__init__() method
----------------------

Parameters:

- **influxdb_client**: An instance of the InfluxDBClient class, used to write any desired data to the InfluxDB container 
- **docker_client**: An instance of the DockerClient class, used to start and stop necessary containers

Tasks: 

- Store parameters for later use

The start() method
------------------

Parameters: 

- **config**: defaults to "", the path of the config file used by the containerized software (if any) 
- **args**: defaults to [], a list of strings to pass to the containerized software on startup (if any)

Tasks: 

- Start the software in a container 
- Start a thread to collect and send any necessary data

The stop() method
-----------------

Tasks: 

- Stop and destroy the container 
- Stop and cleanup any threads
