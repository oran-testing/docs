Quickstart Guide
================

Dependencies
------------

The RAN tester UE system has the following necessary dependencies. Please install them beforehand.

    - `docker <https://docs.docker.com/engine/install/>`_
    - `docker compose <https://docs.docker.com/compose/install/>`_
    - `UHD <https://files.ettus.com/manual/page_install.html>`_


Building the Containers
-------------

First, clone the core repository and its submodules:

.. code-block:: bash

   git clone https://github.com/oran-testing/ran-tester-ue
   cd ran-tester-ue
   git submodule update --init --recursive

Then build the necessary containers:

.. code-block:: bash

   cd docker && sudo docker compose build


Configure Security Test
-------------

The environment is defined in the controller config (`ran-tester-ue/docker/controller/configs`):

.. code-block:: yaml

   processes: # REQUIRED: a list of all processes to start
     - type: "srsue" # REQUIRED: the name of the subprocess class
       config_file: "configs/zmq/ue_zmq_docker.conf" # OPTIONAL: the path to a config file in the subprocess container
       args: "--rrc.sdu_fuzzed_bits 1 --rrc.fuzz_target_message 'rrcSetupRequest'" # OPTIONAL: arguments to pass to the subprocess container

     - type: "jammer"
       config_file: "configs/basic_jammer.yaml"

   influxdb: # OPTIONAL: (but recommended for metrics collection) config for InfluxDB
       influxdb_host: ${DOCKER_INFLUXDB_INIT_HOST} # REQUIRED: The IP or HOSTNAME of InfluxDB container
       influxdb_port: ${DOCKER_INFLUXDB_INIT_PORT} # REQUIRED: The port of the InfluxDB service
       influxdb_org: ${DOCKER_INFLUXDB_INIT_ORG} # REQUIRED: The org of the InfluxDB service
       influxdb_token: ${DOCKER_INFLUXDB_INIT_ADMIN_TOKEN} # REQUIRED: The admin token of the InfluxDB service

   data_backup: # OPTIONAL: configure automatic data backups
       backup_every: 1000 # REQUIRED: Backup data interval in seconds
       backup_dir: test # OPTIONAL: directory to output data
       backup_since: -1d # OPTIONAL: backup starting from

.. note::

   The config used by the controller is defined in `ran-tester-ue/docker/.env` as `DOCKER_CONTROLLER_INIT_CONFIG`.


Start Security Test
-----------

The following will run a jammer and UE with the requested environment, writing all data to InfluxDB and displaying metrics in real-time with Grafana:

.. code-block:: bash

   sudo docker compose up influxdb grafana controller

The Grafana dashboard can be found at `http://localhost:3300`

