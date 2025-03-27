Sniffing Attack
===============

.. note::

   This attack is based on an open-source sniffer tool: `Spritelab 5G Sniffer <https://github.com/spritelab/5GSniffer>`_.


Introduction
************

5GSniffer is an open-source tool that decodes the Physical Downlink Control Channel (PDCCH) of 5G base stations, revealing Downlink Control Information (DCI) and Radio Network Temporary Identifiers (RNTI).
It overcomes 5G-specific challenges, such as decoding encrypted information, and is optimized for efficiency.


Configuring the test
********************

In your controller config, located in ``ran-tester-ue/configs/``, add the following to the processes list:

.. code-block:: yaml

    processes:
    - type: "sniffer"
        id: "dci_sniffer_1"
        config_file: "../5g-sniffer/MSU-Private5G184205.toml"
        rf:
            type: "b200"
            images_dir: "/usr/share/uhd/images/"

The config file for the Sniffer will be located in its submodule at ``ran-tester-ue/5g-sniffer/(config.toml)``:

.. code-block:: toml

    [sniffer]
    file_path = "/home/oran-testbed/5g-sniffer/iq_1842MHz_pdcch_traffic.fc32"
    sample_rate = 23040000
    frequency = 1842500000
    nid_1 = 1
    ssb_numerology = 0
    #rf_args = "type=b200,master_clock_rate=23.04e6"

    [[pdcch]]
    coreset_id = 1
    subcarrier_offset = 426
    num_prbs = 30
    numerology = 0
    dci_sizes_list = [41]
    scrambling_id_start = 1
    scrambling_id_end = 10
    rnti_start = 17921
    rnti_end = 17930
    interleaving_pattern = "non-interleaved"
    coreset_duration = 1
    AL_corr_thresholds = [1, 0.5, 0.5, 1, 1]
    num_candidates_per_AL = [0, 4, 4, 0, 0]


Configuration Reference
***********************

All configuration parameters are presented here below in the following format:

.. code-block:: yaml

    parameter: Parameter description

.. literalinclude:: .config/sniffer_ref.yml
    :language: yaml


For full reference, please check the original source at `Spritelab README <https://github.com/spritelab/5GSniffer/blob/master/README.md#general-sniffer-config-parameters>`_.


Attack Metrics
**************
- MIB (Master Information Block)
- SSB (Synchronization Signal Block)
- Cell frequency
- RNTI (Radio Network Temporary Identifier)
- DCI (Downlink Control Information)


Start the Test
**************

The following will run the Sniffer and UE with the requested environment, writing all data to InfluxDB and displaying metrics in real-time with Grafana:

.. code-block:: bash

   sudo docker compose --profile system up

The Grafana dashboard can be found at `http://localhost:3300 <http://localhost:3300>`_.

