Quickstart Guide
================

Dependencies
------------

The RAN Tester UE system has the following necessary dependencies. Please install them beforehand:

    - `Docker <https://docs.docker.com/engine/install/ubuntu/>`_
    - `UHD <https://files.ettus.com/manual/page_install.html>`_


Building the Containers
-----------------------

First, clone the core repository and its submodules:

.. code-block:: bash

   git clone --recurse-submodules https://github.com/oran-testing/ran-tester-ue

Navigate to the directory and run the system setup script:

.. code-block:: bash

   cd ran-tester-ue
   sudo ./scripts/system_setup.sh

Next, build the necessary containers. Run the following command to pull images for the **components** profile defined in ``~/docker-compose.yaml``, which includes rtUE, Jammer, Uu agent, and Sniffer:

.. code-block:: bash
    
   sudo docker compose --profile components pull

Now, pull images for the **system** profile, which includes Grafana, InfluxDB, and Controller:

.. code-block:: bash

   sudo docker compose --profile system pull

Configure Security Test
-----------------------

The default environment is defined in the controller spec file located at ``ran-tester-ue/spec.yaml``. The following configuration is for a :hoverxref:`Sniffing attack <sniffing_attack>`:

.. code-block:: yaml

    enable_cli: true

    api_auth:
      - name: "mcp-server"
        token: "default_changeme"
        scopes:
          - "start_from_json"
          - "start"
          - "schemas/rtue"
          - "schemas/sniffer"
          - "list"
          - "status"
          - "stop"
          - "logs"
          - "health"
        allowed_components: ["rtue", "sniffer"]

    build_spec:
      - component: "oran-testing/rtue"
        branch: "main"
        pull: true

    run_spec: []

.. note::

   The configuration used by the controller is defined in ``ran-tester-ue/.env`` as **DOCKER_CONTROLLER_INIT_CONFIG**:

    .. code-block:: yaml

        # This points to a configuration on the host machine
        DOCKER_CONTROLLER_INIT_CONFIG=configs/default.yaml


Check Network Configuration
---------------------------

Before starting the containers, check for potential subnet conflicts between Docker's network and your local network interface:

.. code-block:: bash

   ifconfig

If you notice that Docker's default subnet conflicts with your local network subnet, you'll need to change the Docker network configuration. Modify the TCP gateway and subnet in your Docker configuration to use a different range, then restart Docker:

.. code-block:: bash

   sudo systemctl restart docker

After resolving any network conflicts, you can proceed to start the security test.


Start Security Test
-------------------

The following command will run a jammer and UE with the requested environment, writing all data to InfluxDB and displaying metrics in real-time with Grafana:

.. code-block:: bash

   sudo docker compose --profile system up

The Grafana dashboard can be accessed at `http://localhost:3300 <http://localhost:3300>`_.

