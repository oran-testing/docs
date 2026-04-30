Fronthaul Packet Replay Attack
===============================

Introduction
------------

A replay-based denial-of-service evaluation framework for 5G O-RAN fronthaul networks. It takes packet captures, transforms them into configurable attack PCAPs (varying rate, direction, VLAN, and MAC addresses), replays them against a live srsRAN stack (RU emulator + gNB), and analyzes the impact on fronthaul KPIs.

Setup
-----

**Prerequisites**

Hardware: two NICs bound to the fronthaul interfaces:

- ``enp5s0f1``  DU-side injection port 
- ``enp8s0f0np0`` RU-side injection port

If interface names differ, update ``DU_IFACE`` and ``RU_IFACE`` at the top of ``auto_attacker.sh``.

Software: all must be in ``$PATH`` or configured with absolute paths inside the scripts:

- ``tcpreplay`` -- packet replay at line rate
- ``expect`` -- automates interactive gNB startup
- srsRAN gNB binary and RU emulator binary
- ``pcap_gen.py`` from the companion Dos-attacker tool at ``$HOME/Dos-attacker/python_code/pcap_gen.py``
- Python with ``pandas`` (``pip install pandas``)

Permissions: ``tcpreplay`` and the gNB require root. The user running the scripts must have passwordless ``sudo`` or equivalent sudoers entry.


**Generating Attack PCAPs** (``generate_pcap.sh``)

``generate_pcap.sh`` calls ``pcap_gen.py`` for every combination of base capture × rate × direction, writing modified attack PCAPs to ``Traffic/custom/``. ``pcap_gen.py`` rewrites Ethernet headers (VLAN tag, source and destination MACs) and rescales inter-packet timing so the output hits the requested bitrate when replayed at 1× speed.

Example invocation for a single file:

.. code-block:: bash

   python3 $HOME/Dos-attacker/python_code/pcap_gen.py \
       --pcap  Traffic/cp_dl_long_10mb.pcap:1 \
       --out   Traffic/custom/cp_dl_long_10mb_RD_100.pcap \
       --vlan  33 \
       --src   90:e2:ba:8e:39:51 \
       --dst   90:e3:ba:00:12:22 \
       --mbps  100

Argument reference:

- ``--pcap <file:N>`` -- path to the base PCAP; the ``:N`` suffix loops the capture N times when building the output.
- ``--out <path>`` -- destination path for the generated PCAP.
- ``--vlan <id>`` -- VLAN ID injected into every frame; must match the fronthaul VLAN on the DUT (33 in this testbed).
- ``--src <mac>`` -- source MAC written into each frame; set to the DU MAC (``90:e2:ba:8e:39:51``) when sending toward the RU, or the RU MAC (``90:e3:ba:00:12:22``) when sending toward the DU.
- ``--dst <mac>`` -- destination MAC; the counterpart of ``--src``.
- ``--mbps <rate>`` -- target replay rate in Mbps (10, 100, or 1000).

To generate the full set of attack PCAPs:

.. code-block:: bash

   bash generate_pcap.sh
   # Output written to Traffic/custom/

**Output Naming Convention**

Generated PCAPs follow the pattern ``{base_name}_{direction}_{rate}.pcap``:

- ``RD`` -- traffic flowing **R**\U -> **D**\U
- ``DR`` -- traffic flowing **D**\U -> **R**\U
- Rate is one of ``10``, ``100``, or ``1000`` (Mbps)

Example: ``cp_dl_long_10mb_DR_100.pcap`` is a Control-Plane Downlink long-burst capture reshaped to flow DU -> RU at 100 Mbps.


Attack Metrics
--------------

- RU receive-buffer overload (``RX_TOTAL`` spike)
- Increased late or out-of-order packets (``RX_LATE``)
- Degraded or lost transmit throughput (``TX_TOTAL`` drop)
- gNB or RU emulator crash
- Fronthaul link saturation with no recovery
- Any other useful KPI degradation observed in the logs


Running the Test
----------------

**Step 1 -- Run the automated attacker:**

.. code-block:: bash

   sudo bash auto_attacker.sh
   # Per-trial logs written to attack_results/
   # Crash events recorded in attack_results/crash_logs.txt

The script iterates over every PCAP in ``Traffic/custom/`` and tests each at both injection points, logging a 10-second monitoring window per trial.

**Step 2 -- Analyze results:**

.. code-block:: bash

   pip install pandas
   python3 parse_log.py

To run the full pipeline (generate -> attack -> analyze) in one command:

.. code-block:: bash

   python3 main.py
