RRC Fuzzing Attack
==================

Introduction
************

Random Radio Resource Control (RRC) fuzzing is a type of attack where random modifications are made to the values within the Service Data Unit (SDU) buffer of the RRC layer. After altering these values, the corrupted buffer is sent to the gNB (next-generation Node B). The goal of this process is to exploit potential vulnerabilities in the gNB's handling of RRC messages, potentially causing system malfunctions or unexpected behavior.


Configuring the test
********************

In your controller config, located in ``ran-tester-ue/configs/``, add the following to the processes list:

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
**************

- gNB overload /crash
- Detach existing UEs
- Discovery of buffer overflow vulnerabilities


Start Security Test
*******************

The following will run a UE fuzzer with the requested environment, writing all data to InfluxDB and displaying metrics in real-time with Grafana:

.. code-block:: bash

   sudo docker compose --profile system up

The Grafana dashboard can be found at `http://localhost:3300 <http://localhost:3300>`_.

