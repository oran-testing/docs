RACH Flooding Attack
====================

Introduction
------------
The RACH (Random Access Channel) procedure is used for the initial connection and communication between the UE and the gNB. This attack specifically targets the RACH preamble message (msg1).

The following are the contents of the RACH preamble message:

.. code-block:: txt

    sequence_index
    ta
    prb
    symb
    snr

When the UE is run with the correct arguments, it will attempt to send valid RACH preambles using every sequence_index.

More information on the RACH procedure can be found here: `sharetechnote <https://www.sharetechnote.com/html/5G/5G_RACH.html>`_.

Configure Security Test
-----------------------

In your controller config, located in ``docker/controller/configs/``, add the following to the processes list:

.. code-block:: yaml

   processes:
    - type: "rtue"
      config_file: "configs/uhd/ue_uhd.conf"
      args: "--prach.rach_flooding_attack_enabled true"
 
Attack Metrics
--------------
- Inability to register new UEs to the RAN
- UE disconnect
- RAN crash or freeze
- Timing issues with existing UEs

Start Security Test
-------------------

The following will run the RACH flooding attack with the requested environment, writing all data to InfluxDB and displaying metrics in real-time with Grafana:

.. code-block:: bash

   sudo docker compose up influxdb grafana controller

The Grafana dashboard can be found at `http://localhost:3300`

