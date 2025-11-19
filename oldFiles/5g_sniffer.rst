.. _sniffing_attack:

Sniffing Attack
===============

.. note::

   This attack is based on the open-source `Spritelab 5G Sniffer <https://github.com/spritelab/5GSniffer>`_.


Introduction
------------

5G Sniffer is an open-source tool that decodes the Physical Downlink Control Channel (PDCCH) of 5G base stations, revealing Downlink Control Information (DCI) and Radio Network Temporary Identifiers (RNTI).
It overcomes 5G-specific challenges, such as decoding encrypted information, and is optimized for efficiency.


Configuring the Test
--------------------
**Controller Configuration:**
Add the following to the `processes` list in the controller configuration located at ``ran-tester-ue/configs/default.yaml``:

.. code-block:: yaml

    processes:
    - type: "sniffer"
        id: "dci_sniffer_1"
        config_file: "../5g-sniffer/MSU-Private5G184205.toml"
        rf:
            type: "b200"
            images_dir: "/usr/share/uhd/images/"


**Sniffer Configuration:**
The sniffer configuration file is located at ``ran-tester-ue/5g-sniffer/5gsniffer/(config.toml)``. Refer to the parameter reference for details:


.. code-block:: yaml

    parameter: <default value>  # Parameter description

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

Start the Sniffing attack in the requested environment with real-time metrics displayed in Grafana:

.. code-block:: bash

   sudo docker compose --profile system up

Access Grafana dashboard at `http://localhost:3300 <http://localhost:3300>`_.