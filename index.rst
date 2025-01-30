NTIA RAN Tester UE
==================

Penetration testing tool for 5G and O-RAN security vulnerabilities using software-defined radio UE emulation.

Overview
--------

This project is a security testing tool based on the srsRAN Project's User Equipment, designed to test 5G and open radio access networks (RANs) via the Uu air interface between the UE and the network. While enabling various types of testing, the primary focus of this software is on RAN security testing.  

This software-defined testing UE (T-UE) is fully software-based and compatible with widely available, commercial off-the-shelf (COTS) software radio hardware. Standardized 3GPP or O-RAN tests, as well as custom test procedures, can be implemented and executed at minimal cost and at different stages of RAN development and integration. This system facilitates testing across multiple commercial and open-source RAN implementations with minimal technical overhead. Additionally, many attacks on the RAN can be executed automatically by the system.

System Architecture
-------------------

.. image:: images/soft-t-ue-system.png


.. toctree::
   :maxdepth: 1
   :caption: Getting Started

   Quickstart <rstFiles/quickstart>
   Installation <rstFiles/installation>
   Configuration <rstFiles/configuration>
   Routing Traffic <rstFiles/ip_routing>


.. toctree::
   :maxdepth: 1
   :caption: Attacks

   Jamming <attacks/jamming_attack>
   Fuzzing <attacks/fuzzing_attack>
   Flooding <attacks/flooding_attack>


.. toctree::
   :maxdepth: 1
   :caption: Metrics

   Grafana <rstFiles/grafana_metrics>
   srsUE Metrics <rstFiles/metrics_documentation>


.. toctree::
   :maxdepth: 1
   :caption: Architecture

   Overview <rstFiles/components>
   Container Jobs <rstFiles/container_jobs>


.. toctree::
   :maxdepth: 1
   :caption: For Developers

   Development Overview <rstFiles/development>
   Message Types <rstFiles/message_types>
   Monitor Thread API <rstFiles/controller_api_guide>

