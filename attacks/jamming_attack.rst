Jamming Attack
===============

Introduction
************

Jamming is the intentional disruption of a wireless signal by transmitting a strong interference on the same frequency, blocking or degrading the intended communication.
Currently, there are 4 main jamming methods `[1] <https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5343062>`_ :

1. Spot Jamming
2. Sweep Jamming
3. Barrage Jamming
4. Deceptive Jamming

In our system, we have currently implemented Spot Jamming, where all malicious transmission power is directed at a single frequency used by the target, utilizing the same modulation and sufficient power to override the original signal.


Configuring the test
********************

In your controller config, located in ``configs/`` add the following to the processes list:

.. code-block:: yaml

   processes:
    - type: "jammer"
      id: "jammer_1"
      config_file: "configs/basic_jammer.yaml"
      rf:
         type: "b200"
         images_dir: "/usr/share/uhd/images/"


Attack Metrics
**************

- Inability of UEs to connect
- Low channel quality
- gNB overload /crash
- UE detach


Start the Test
**************

The following will run a jammer and UE with the requested environment, writing all data to InfluxDB and displaying metrics in real-time with Grafana:

.. code-block:: bash

   sudo docker compose --profile system up

The Grafana dashboard can be found at `http://localhost:3300 <http://localhost:3300>`_.

