Jamming Attack
===============

Introduction
------------

Jamming is the intentional disruption of a wireless signal by transmitting a strong interference on the same frequency, blocking or degrading the intended communication.
The primary jamming methods are:

1. Spot Jamming (implemented in this system)
2. Sweep Jamming
3. Barrage Jamming
4. Deceptive Jamming

**Spot jamming** is a type of noise jamming where a jammer concentrates its power on a single frequency, aiming to disrupt communication or radar systems operating on that specific frequency.

Configuration
-------------
**Controller Configuration:**
Add the following to the `processes` list in the controller configuration located at ``ran-tester-ue/configs/default.yaml``:

.. code-block:: yaml

   processes:
    - type: "jammer"
      id: "jammer_1"
      config_file: "configs/basic_jammer.yaml"
      rf:
         type: "b200"
         images_dir: "/usr/share/uhd/images/"

**Jammer Configuration:**
The jammer configuration file is located at ``ran-tester-ue/jammer/configs/basic_jammer.yaml``. Refer to the parameter reference for details:

.. code-block:: yaml

    parameter: default_value        # Parameter description

.. literalinclude:: .config/jammer_ref.yml
    :language: yaml


Attack Metrics
--------------

- UE connection failures
- Degraded channel quality
- gNB overload or crash
- UE detach events


Running the Test
----------------

Start the Jamming attack in the requested environment with real-time metrics displayed in Grafana:

.. code-block:: bash

   sudo docker compose --profile system up

Access Grafana dashboard at `http://localhost:3300 <http://localhost:3300>`_.