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

   Quickstart <getting_started/quickstart>
   Routing Traffic <getting_started/ip_routing>
   Configuration Reference <getting_started/configuration>

.. toctree::
   :maxdepth: 1
   :caption: Attack Components

   rtUE <components/rtue>
   OAI UE <components/oai_ue>
   OFH Attacker <components/ofh_attacker>
   Sni5Gect <components/sni5gect>
   RACH Agent <components/rach_agent>
   SSB Spoofer <components/ssb_spoofer>
   Jammer <components/jammer>
   UU Agent <components/uu_agent>
   LLM Worker <components/llm_worker>
   LLM Analyzer <components/llm_analyzer>

.. toctree::
   :maxdepth: 1
   :caption: Architecture

   System Controller <architecture/controller>
   InfluxDB and Grafana <architecture/metrics>
   Components <architecture/components>
   Inter-Machine Communication <architecture/imc>

.. toctree::
   :maxdepth: 1
   :caption: For Developers

   Coding Style <development/coding_style>
   Control API <development/control_api>
   Adding a Component <development/controller_api_guide>

