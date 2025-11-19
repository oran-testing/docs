RACH Flooding Attack
====================

Introduction
------------

The Random Access Channel (RACH) procedure facilitates initial communication between UE and the gNB. This attack targets the RACH preamble message (msg1), which contains:

.. code-block:: txt

    sequence_index
    ta
    prb
    symb
    snr

When enabled, the UE sends valid RACH preambles using every **sequence_index**.

For more details on  the RACH procedure, refer to `ShareTechnote <https://www.sharetechnote.com/html/5G/5G_RACH.html>`_.


Configuration
-------------

**Controller Configuration:**
Add the following to the `processes` list in the controller configuration located at ``ran-tester-ue/configs/default.yaml``:

.. code-block:: yaml

   processes:
    - type: "rtue"
      id: "rtue_uhd_1"
      config_file: "configs/uhd/ue_uhd.conf"
      args: "--prach.rach_flooding_attack_enabled true"
      rf:
         type: "b200"
         images_dir: "/usr/share/uhd/images/"
 

Attack Metrics
--------------

- Failure to register new UEs
- UE disconnections
- RAN crashes or freezes
- Timing issues for connected UEs


Running the Test
----------------

Start the RACH flooding attack in the requested environment with real-time metrics displayed in Grafana:

.. code-block:: bash

   sudo docker compose --profile system up

Access Grafana dashboard at `http://localhost:3300 <http://localhost:3300>`_.