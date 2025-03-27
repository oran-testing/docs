NTIA RAN Tester UE
==================

Penetration testing tool for 5G and O-RAN security vulnerabilities using software-defined radio UE emulation.

Overview
--------

This project is a security testing tool based on modifications and attacks from the User Equipment, designed to test 5G and open radio access networks (RANs) via the Uu air interface between the UE and the network. While enabling various types of testing, the primary focus of this software is on RAN security testing.  

This RAN Tester UE (rtUE) is fully software-based and compatible with widely available, commercial off-the-shelf (COTS) software radio hardware. Standardized 3GPP or O-RAN tests, as well as custom test procedures, can be implemented and executed at minimal cost and at different stages of RAN development and integration. This system facilitates testing across multiple commercial and open-source RAN implementations with minimal technical overhead. Additionally, many attacks on the RAN can be executed automatically by the system.

.. image:: images/soft-t-ue-system.png

Getting Help
------------

This project is still in development. If you find any issues, please create a GitHub issue on our repository: `ran-tester-ue <https://github.com/oran-testing/ran-tester-ue>`_

Our team will respond to any issues as quickly as possible. We appreciate any feedback as we continue to add to our documentation.


.. toctree::
   :maxdepth: 1
   :caption: Getting Started

   Quickstart <rstFiles/quickstart>
   Installation <rstFiles/installation>
   Routing Traffic <rstFiles/ip_routing>


.. toctree::
   :maxdepth: 1
   :caption: Attacks

   Jamming <attacks/jamming_attack>
   RACH flooding <attacks/rach_flood_attack>
   RRC fuzzing <attacks/rrc_fuzz_attack>
   Sniffing (old) <attacks/5g_sniffer_old>
   Sniffing (new) <attacks/5g_sniffer_new>

.. toctree::
   :maxdepth: 1
   :caption: Metrics

   Grafana <rstFiles/grafana_metrics>
   rtUE Metrics <rstFiles/metrics_documentation>


.. toctree::
   :maxdepth: 1
   :caption: Architecture

   Overview <rstFiles/container_jobs>


.. toctree::
   :maxdepth: 1
   :caption: For Developers

   Development Overview <rstFiles/development>
   Message Types <rstFiles/message_types>
   Monitor Thread API <rstFiles/controller_api_guide>
