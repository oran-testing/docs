RRC Fuzzing Attack
==================

Introduction
------------

Radio Resource Control (RRC) fuzzing involves random modifications to values within the Service Data Unit (SDU) buffer at the RRC layer. The altered buffer is sent to the gNodeB (gNB) to exploit potential vulnerabilities, potentially causing system malfunctions or unexpected behavior.

Configuring the Test
--------------------

**Controller Configuration:**
Add the following to the `processes` list in the controller configuration located at ``ran-tester-ue/configs/default.yaml``:

.. code-block:: yaml

   processes:
    - type: "rtue"
      id: "rtue_uhd_1"
      config_file: "configs/uhd/ue_uhd.conf"
      args: "--rrc.sdu_fuzzed_bits 1 --rrc.fuzz_target_message 'rrcSetupRequest'"
      rf:
         type: "b200"
         images_dir: "/usr/share/uhd/images/"


Attack Metrics
--------------

- gNB overload or crash
- UE detach events
- Discovery of buffer overflow vulnerabilities


Running the Test
----------------

Start the fuzzing attack in the requested environment with real-time metrics displayed in Grafana:

.. code-block:: bash

   sudo docker compose --profile system up

Access Grafana dashboard at `http://localhost:3300 <http://localhost:3300>`_.
