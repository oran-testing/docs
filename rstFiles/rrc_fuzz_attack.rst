RRC Fuzzing Attack
===================

Introduction
-------------
Random RRC fuzzing is a type of attack where random modifications are made to the values within the Service Data Unit (SDU) buffer of the Radio Resource Control (RRC) layer. After altering these values, the corrupted buffer is sent to the gNB (next-generation Node B). The goal of this process is to exploit potential vulnerabilities in the gNB's handling of RRC messages, potentially causing system malfunctions or unexpected behavior.


Configure Security test
------------------

The environment is defined in the controller config (`ran-tester-ue/docker/controller/configs`):

.. code-block:: yaml

   processes: # REQUIRED: a list of all processes to start
     - type: "rtue" # REQUIRED: the name of the subprocess class
       config_file: "configs/zmq/ue_zmq_docker.conf" # OPTIONAL: the path to a config file in the subprocess container
       args: "--rrc.sdu_fuzzed_bits 1 --rrc.fuzz_target_message 'rrcSetupRequest'" # OPTIONAL: arguments to pass to the subprocess container




Attack Metrics
----------------
- gNB overload /crash
- Detach existing UEs
- Discovery of buffer overflow vulnerabilities


Start Security Test
-----------

The following will run a UE fuzzer with the requested environment, writing all data to InfluxDB and displaying metrics in real-time with Grafana:

.. code-block:: bash

   sudo docker compose up influxdb grafana controller

The Grafana dashboard can be found at `http://localhost:3300`

