Quickstart Guide
================

Dependencies
------------

The RAN Tester UE system has the following necessary dependencies. Please install them beforehand.

    - `Docker <https://docs.docker.com/engine/install/ubuntu/>`_
    - `UHD <https://files.ettus.com/manual/page_install.html>`_


Building the Containers
-----------------------

First, clone the core repository and its submodules:

.. code-block:: bash

   git clone --recurse-submodules https://github.com/oran-testing/ran-tester-ue

Then, build the necessary containers:

Run this to pull images for the **components** profile defined in ``~/docker-compose.yaml``, which includes rtUE, Jammer, Uu agent, and Sniffer.

.. code-block:: bash
    
   cd ~/ran-tester-ue 
   sudo docker compose --profile components pull

Now, run this to pull images for the **system** profile, which includes Grafana, InfluxDB, and Controller.

.. code-block:: bash

   sudo docker compose --profile system pull

Configure Security Test
-----------------------

The default environment is defined in the controller configuration file located at ``ran-tester-ue/configs/(config.yaml)``. The config shown below is for :hoverxref:`Sniffing attack <sniffing_attack>`.

.. code-block:: yaml

    processes:                                                  # List of all processes to start
    - type: "rtue"
        id: "rtue_uhd_1"
        config_file: "configs/uhd/ue_uhd.conf"                  # Path to the configuration file for the rtUE
        rf:
            type: "b200"                                        # Type of RF device (= USRP B210)
            images_dir: "/usr/share/uhd/images/"                # Directory for RF images

    - type: "sniffer"
        id: "dci_sniffer_1"
        config_file: "../5g-sniffer/MSU-Private5G184205.toml"   # Path to the configuration file for the sniffer
        rf:
            type: "b200"
            images_dir: "/usr/share/uhd/images/"

.. note::

   The config used by the controller is defined in ``ran-tester-ue/.env`` as **DOCKER_CONTROLLER_INIT_CONFIG**.

    .. code-block:: yaml

        # This points to a configuration on the host machine
        DOCKER_CONTROLLER_INIT_CONFIG=configs/default.yaml


Start Security Test
-------------------

The following will run a jammer and UE with the requested environment, writing all data to InfluxDB and displaying metrics in real-time with Grafana:

.. code-block:: bash

   sudo docker compose --profile system up

The Grafana dashboard can be found at `http://localhost:3300 <http://localhost:3300>`_.

