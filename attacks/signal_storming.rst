Signaling Storm Injection Attack
================================

Introduction
------------

The Signaling Storm (``sstorm``) component repeatedly attaches to a target cell and floods connection requests (RACH storm) to stress-test a RAN's control-plane capacity. This simulates a signaling storm where a malicious UE generates a high volume of attach requests, service requests, or other NAS signaling messages to overload the gNB.

The sstorm component uses the srsUE ``.conf`` (INI) configuration layout.

Configuration
-------------

**MCP Server (start_component):**

Use the ``sstorm`` component type. JSON keys follow the srsUE config format with section prefixes:

.. code-block:: json

   {
     "id": "basic_zmq_signal_storm",
     "ue_signal_storm": true,
     "rf_srate": 23040000,
     "rf_tx_gain": 70,
     "rf_rx_gain": 40,
     "rf_nof_antennas": 1,
     "rf_device_name": "uhd",
     "rf_device_args": "type=b200, clock=external",
     "rf_time_adv_nsamples": 300,
     "rat_nr_bands": 3,
     "rat_nr_nof_carriers": 1,
     "rat_nr_max_nof_prb": 106,
     "rat_nr_nof_prb": 106,
     "usim_imsi": "001010123456789",
     "nas_apn": "srsapn",
     "log_all_level": "error"
   }

**Required fields:** ``id``, ``ue_signal_storm``, ``rf_srate``, ``rf_tx_gain``, ``rf_rx_gain``, ``rat_nr_bands``, ``rat_nr_nof_prb``, ``usim_imsi``, ``nas_apn``

**Configuration parameters:**

UE Section (prefix: ``ue_``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- ``signal_storm`` (boolean): Enable signal storm / RACH flooding

RF Section (prefix: ``rf_``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- ``srate``: Sample rate in Hz
- ``tx_gain``: TX gain in dB (0-90)
- ``rx_gain``: RX gain in dB (0-90)
- ``nof_antennas``: Number of antennas
- ``device_name``: RF device name (e.g., ``uhd``)
- ``device_args``: Device arguments
- ``time_adv_nsamples``: Time advance in samples

NR Section (prefix: ``rat_nr_``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- ``bands``: NR band number
- ``nof_carriers``: Number of carriers
- ``max_nof_prb``: Maximum number of PRBs
- ``nof_prb``: Number of PRBs

USIM Section (prefix: ``usim_``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- ``imsi``: IMSI (exactly 15 digits)

NAS Section (prefix: ``nas_``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- ``apn``: APN name

Attack Metrics
--------------

1. **Signaling Message Rate**:
   - Rate at which attach requests are sent and received by the gNB
   - Total number of signaling messages over a specified period

2. **Network Performance**:
   - Impact on throughput and overall network performance
   - Service disruption or delays for other UEs

3. **Resource Utilization**:
   - CPU and memory usage on the gNB
   - Overall network load and resource consumption

Papers
------

`https://dl.acm.org/doi/pdf/10.1145/2642687.2642688 <https://dl.acm.org/doi/pdf/10.1145/2642687.2642688>`_

Running the Test
----------------

**1. Controller Spec**

Use the dedicated ``sstorm`` controller spec (``configs/sstorm.yaml``):

.. code-block:: yaml

   enable_cli: true

   api_auth:
     - name: "mcp-server"
       token: "testing_token"
       scopes:
         - "start_from_json"
         - "start"
         - "schemas/sstorm"
         - "list"
         - "status"
         - "stop"
         - "logs"
         - "health"
       allowed_components: ["sstorm"]

   build_spec:
     - component: "cueltschey/sstorm-rectest"
       branch: "master"
       pull: true

   run_spec:
     - component: "cueltschey/sstorm-rectest"
       worker_thread: "sstorm"
       name: "basic_zmq_signal_storm"
       config_file: "configs/srsran/sstorm.conf"
       rf:
         type: "b200"

.. code-block:: bash

   CONTROLLER_SPEC=configs/sstorm.yaml docker compose up -d

**2. Start the Signaling Storm via the MCP server:**

.. code-block:: json

   {
     "component_type": "sstorm",
     "config_json": {
       "id": "basic_signal_storm",
       "ue_signal_storm": true,
       "rf_srate": 23040000,
       "rf_tx_gain": 70,
       "rf_rx_gain": 40,
       "rat_nr_bands": 3,
       "rat_nr_nof_prb": 106,
       "usim_imsi": "001010123456789",
       "nas_apn": "srsapn"
     },
     "rf_config": {"type": "b200"}
   }

For simulation (no hardware), use ``rf_config: {"type": "zmq"}`` with appropriate ``rf_device_args``.

Monitor with ``get_component_health`` and ``get_component_logs``. Stop with ``stop_component``.