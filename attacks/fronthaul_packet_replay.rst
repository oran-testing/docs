Fronthaul Packet Replay
=======================

Introduction
------------

A replay-based denial-of-service evaluation framework for 5G O-RAN fronthaul networks. It takes packet captures, transforms them into configurable attack PCAPs (varying rate, direction, VLAN, and MAC addresses), replays them against a live srsRAN stack (RU emulator + gNB), and analyzes the impact on fronthaul KPIs.

This attack is implemented via the **ofh** (Open Fronthaul) component.

Configuration
-------------

**MCP Server (start_component):**

Use the ``ofh`` component type with the following JSON configuration:

.. code-block:: json

   {
     "id": "ofh_attacker_1",
     "injection_points": ["DU", "RU"],
     "pcap_dir": "Traffic/",
     "pcap_list": [],
     "du": "enp5s0f1",
     "ru": "enp8s0f0np0",
     "attacker_dir": "/attack_env",
     "results_dir": "./attack_results",
     "duration_seconds": 10,
     "tcpreplay_topspeed": 1,
     "tcpreplay_loop": 0,
     "keep_history": "0"
   }

**Configuration parameters:**

- ``injection_points``: List of injection points (``"DU"``, ``"RU"``, or both)
- ``pcap_dir``: Directory containing base PCAP captures
- ``pcap_list``: Specific PCAP files to replay (empty = all in pcap_dir)
- ``du``: Network interface for DU-side injection
- ``ru``: Network interface for RU-side injection
- ``attacker_dir``: Working directory inside the attacker container
- ``results_dir``: Output directory for attack results
- ``duration_seconds``: Duration of each attack trial in seconds
- ``tcpreplay_topspeed``: Replay at maximum possible speed (1 = enabled)
- ``tcpreplay_loop``: Number of replay loops (0 = infinite)
- ``keep_history``: Preserve history between runs (``"0"`` = discard)

Setup
-----

**Prerequisites**

Hardware: two NICs bound to the fronthaul interfaces:

- ``enp5s0f1`` DU-side injection port
- ``enp8s0f0np0`` RU-side injection port

**Generating Attack PCAPs**

The fronthaul attacker replays pre-generated PCAP files. Example PCAP generation:

.. code-block:: bash

   python3 $HOME/Dos-attacker/python_code/pcap_gen.py \
       --pcap  Traffic/cp_dl_long_10mb.pcap:1 \
       --out   Traffic/custom/cp_dl_long_10mb_RD_100.pcap \
       --vlan  33 \
       --src   90:e2:ba:8e:39:51 \
       --dst   90:e3:ba:00:12:22 \
       --mbps  100

PCAP naming convention: ``{base_name}_{direction}_{rate}.pcap``

- ``RD``: traffic flowing RU -> DU
- ``DR``: traffic flowing DU -> RU
- Rate: ``10``, ``100``, or ``1000`` (Mbps)

Attack Metrics
--------------

- RU receive-buffer overload (``RX_TOTAL`` spike)
- Increased late or out-of-order packets (``RX_LATE``)
- Degraded or lost transmit throughput (``TX_TOTAL`` drop)
- gNB or RU emulator crash
- Fronthaul link saturation with no recovery

Running the Test
----------------

**1. Controller Spec**

Use the dedicated ``ofh_attacker`` controller spec (``configs/ofh_attacker.yaml``):

.. code-block:: yaml

   enable_cli: true

   api_auth:
     - name: "mcp-server"
       token: "testing_token"
       scopes:
         - "start_from_json"
         - "start"
         - "schemas/ofh"
         - "list"
         - "status"
         - "stop"
         - "logs"
       allowed_components: ["ofh"]

   build_spec:
     - component: "oran-testing/Dos-attacker"
       branch: "main"
       pull: true

   run_spec:
     - component: "oran-testing/Dos-attacker"
       worker_thread: "ofh_attacker"
       name: "ofh_attacker_1"
       config_file: "configs/ofh/ofh.toml"
       rf:
         type: "none"

.. code-block:: bash

   CONTROLLER_SPEC=configs/ofh_attacker.yaml docker compose up -d

**2. Start the Fronthaul Packet Replay via the MCP server:**

.. code-block:: json

   {
     "component_type": "ofh",
     "config_json": {
       "id": "ofh_attacker_1",
       "injection_points": ["DU", "RU"],
       "pcap_dir": "Traffic/",
       "du": "enp5s0f1",
       "ru": "enp8s0f0np0",
       "duration_seconds": 10,
       "tcpreplay_topspeed": 1
     },
     "rf_config": {"type": "none"}
   }

The OFH attacker does not use RF hardware (``rf_config: {"type": "none"}``). It operates entirely over Ethernet.

Monitor with ``get_component_health`` and ``get_component_logs``. Stop with ``stop_component``.