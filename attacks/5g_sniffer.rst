.. _sniffing_attack:

Sniffing Attack
===============

.. note::

   This attack is based on the open-source `Spritelab 5G Sniffer <https://github.com/spritelab/5GSniffer>`_.

Introduction
------------

5G Sniffer is an open-source tool that decodes the Physical Downlink Control Channel (PDCCH) of 5G base stations, revealing Downlink Control Information (DCI) and Radio Network Temporary Identifiers (RNTI). It overcomes 5G-specific challenges, such as decoding encrypted information, and is optimized for efficiency.

Configuration
-------------

**MCP Server (start_component):**

Use the ``sniffer`` component type with the following JSON configuration schema:

.. code-block:: json

   {
     "id": "dci_sniffer_1",
     "file_path": "/home/oran-testbed/5g-sniffer/iq_1842MHz_pdcch_traffic.fc32",
     "sample_rate": 23040000,
     "frequency": 1842500000,
     "nid_1": 1,
     "ssb_numerology": 0,
     "pdcch_coreset_id": 1,
     "pdcch_subcarrier_offset": 426,
     "pdcch_num_prbs": 30,
     "pdcch_numerology": 0,
     "pdcch_dci_sizes_list": [41],
     "pdcch_scrambling_id_start": 1,
     "pdcch_scrambling_id_end": 10,
     "pdcch_rnti_start": 17921,
     "pdcch_rnti_end": 17930,
     "pdcch_interleaving_pattern": "non-interleaved",
     "pdcch_coreset_duration": 1,
     "pdcch_AL_corr_thresholds": [1, 0.5, 0.5, 1, 1],
     "pdcch_num_candidates_per_AL": [0, 4, 4, 0, 0]
   }

**Required fields:** ``id``, ``file_path``, ``sample_rate``, ``frequency``, ``nid_1``, ``ssb_numerology``

**Field Reference:**

.. literalinclude:: .config/sniffer_ref.yml
    :language: yaml

Refer to the `Spritelab README <https://github.com/spritelab/5GSniffer/blob/master/README.md#general-sniffer-config-parameters>`_ for a comprehensive reference.

Attack Metrics
--------------

- MIB (Master Information Block)
    - Cell ID
    - SFN (Single-frequency network)
    - SCS (Supplemental Coverage from Space)
    - CFO (Carrier Frequency Offset)
- SSB (Synchronization Signal Block)
- Cell frequency
- RNTI (Radio Network Temporary Identifier)
- DCI (Downlink Control Information)
    - Slot index
    - Correlation
    - Symbol in chunk
    - Sample time
    - Found aggregation level

Running the Test
----------------

**1. Controller Spec**

Add the sniffer to the controller spec (``spec.yaml``):

.. code-block:: yaml

   build_spec:
     - component: "oran-testing/rtue"
       branch: "main"
       pull: true

   api_auth:
     - name: "mcp-server"
       token: "default_changeme"
       scopes:
         - "start_from_json"
         - "start"
         - "schemas/sniffer"
         - "list"
         - "status"
         - "stop"
       allowed_components: ["sniffer"]

   run_spec: []

Then start the controller:

.. code-block:: bash

   docker compose up -d

**2. Start the Sniffing attack via the MCP server:**

.. code-block:: json

   {
     "component_type": "sniffer",
     "config_json": {
       "id": "dci_sniffer_1",
       "file_path": "/tmp/sniffer_output.fc32",
       "sample_rate": 23040000,
       "frequency": 1842500000,
       "nid_1": 1,
       "ssb_numerology": 0
     },
     "rf_config": {"type": "b200"}
   }

Monitor with ``get_component_health`` and ``get_component_logs``. Stop with ``stop_component``.