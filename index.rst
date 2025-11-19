NTIA RAN Tester UE
==================

Penetration testing framework for 5G and O-RAN security vulnerabilities using software-defined radio UE emulation.

Overview
--------

This project is a security testing tool based on modifications and components from the User Equipment, designed to test 5G and open radio access networks (RANs) via the Uu air interface between the UE and the network. While enabling various types of testing, the primary focus of this software is on RAN security testing.  

This RAN Tester UE (rtUE) is fully software-based and compatible with widely available, commercial off-the-shelf (COTS) software radio hardware. Standardized 3GPP or O-RAN tests, as well as custom test procedures, can be implemented and executed at minimal cost and at different stages of RAN development and integration. This system facilitates testing across multiple commercial and open-source RAN implementations with minimal technical overhead. Additionally, many components on the RAN can be executed automatically by the system.

.. image:: images/soft-t-ue-system.png

Getting Help
------------

This project is still in development. If you find any issues, please create a GitHub issue on our repository: `ran-tester-ue <https://github.com/oran-testing/ran-tester-ue>`_

Our team will respond to any issues as quickly as possible. We appreciate any feedback as we continue to add to our documentation.


.. toctree::
   :maxdepth: 1
   :caption: Getting Started

   Quickstart <mdFiles/getting_started/quickstart>
   Routing Traffic <mdFiles/getting_started/ip_routing>
   Configuration Reference <mdFiles/getting_started/configuration>

.. toctree::
   :maxdepth: 1
   :caption: Attack Components

   rtUE <mdFiles/components/rtue>
   OAI UE <mdFiles/components/oai_ue>
   OFH Attacker <mdFiles/components/ofh_attacker>
   Sni5Gect <mdFiles/components/sni5gect>
   RACH Agent <mdFiles/components/rach_agent>
   SSB Spoofer <mdFiles/components/ssb_spoofer>
   Jammer <mdFiles/components/jammer>
   UU Agent <mdFiles/components/uu_agent>
   LLM Worker <mdFiles/components/llm_worker>
   LLM Analyzer <mdFiles/components/llm_analyzer>

.. toctree::
   :maxdepth: 1
   :caption: Architecture

   System Controller <mdFiles/architecture/controller>
   InfluxDB and Grafana <mdFiles/architecture/metrics>
   Components <mdFiles/architecture/components>
   Inter-Machine Communication <mdFiles/architecture/imc>

.. toctree::
   :maxdepth: 1
   :caption: For Developers

   Coding Style <mdFiles/development/coding_style>
   Control API <mdFiles/development/control_api>
   Adding a Component <mdFiles/development/controller_api_guide>

