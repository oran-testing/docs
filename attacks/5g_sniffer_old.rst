Sniffing Attack
===============

.. note::

   This attack is based on an open-source sniffer tool: `Spritelab 5G Sniffer <https://github.com/spritelab/5GSniffer>`_.


Introduction
------------

5GSniffer is an open-source tool that decodes the Physical Downlink Control Channel (PDCCH) of 5G base stations, revealing Downlink Control Information (DCI) and Radio Network Temporary Identifiers (RNTI).
It overcomes 5G-specific challenges, such as decoding encrypted information, and is optimized for efficiency.


Configuration file for 5G-sniffer:

.. image:: /images/5g_sniffer/required_param.png


The parameters mentioned above can be found in ``tmp/gnb.log`` file. 

.. image:: /images/5g_sniffer/frequency.png


In other to decode frequency from DL ARFCN, we used `ARFCN Calculator <https://www.cellmapper.net/arfcn>`_. For the DL ARFCN of 368500, the frequency is 1842050000 Hz.

The number of PRBs and subcarrier offset were determined by running the brute-force script, which ran the Sniffer in ZeroMQ mode with collected IQ samples.


.. code:: bash

    ControlResourceSetID = Corset ID = 1
    Corset Duration = 1
    No of Candidates = num_candidates_per_AL = [0,4,4,0,0]
    AL_corr_threshold = [1,0.5,0.5,1,1]   // Replace 0s with 1s and values greater than 0 with 0.5.


.. image:: /images/5g_sniffer/dci_size.png

.. image:: /images/5g_sniffer/corset_param.png


How to run
----------

.. code:: bash

    ./build/src/5gsniffer ./5g_MSU_sniffer.toml

Output
------

.. image:: /images/5g_sniffer/sniffer_output.png

The information from PDCCH were decoded by running the Sniffer, and they are as follows:

* MIB (Master Information Block)
* SSB (Synchronization Signal Block)
* Cell frequency
* RNTI (Radio Network Temporary Identifier)
* DCI (Downlink Control Information)
