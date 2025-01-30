Understanding the Overall Project
---------------------------------

srsRAN Project
~~~~~~~~~~~~~~

The srsRAN Project is a complete 5G RAN solution, featuring an ORAN-native CU/DU developed by SRS. The solution includes a complete L1/2/3 implementation with minimal external dependencies. Portable across processor architectures, the software has been optimized for x86 and ARM[1][2].

Current Features
~~~~~~~~~~~~~~~~

- **3GPP release 17 aligned**: 3GPP was created in 1998 to develop 3G mobile standards for WCDMA and TD-SCDMA accesses and their core networks. The aim was to maintain and evolve the ETSI standards for the (2G) GSM system. The rocketing number of use cases for 5G is creating new requirements and is making a real impact on the 3GPP prioritization process for new studies and normative efforts in the groups[6].

- **FDD/TDD supported, all FR1 bands**: In FDD, the uplink and downlink each use their own frequency so they can both transmit and receive at the same time without risk of interference. In TDD networks, the uplink and downlink share the same frequency, so the transmission of signals requires precise scheduling to avoid interference[6].

- **All bandwidths (e.g. 100 MHz TDD, 50 MHz FDD)**[6]

- **15/30 kHz subcarrier spacing**: 15, 30, and 60 kHz subcarrier spacing are used for the lower frequency bands, and 60, 120, and 240 kHz subcarrier spacing are used for the higher frequency bands[6].

- **NTN GEO support**: 5G NTN-NR is the next phase of NTN technology. NTN-NR will provide services similar to that of NTN-IoT but at a much greater scale. It will directly link smartphones and other 5G devices for non-terrestrial services[6].

- **Slicing**: Network slicing is a telecommunications configuration that allows multiple networks (virtualized and independent) to be created on top of a common physical infrastructure. Each "slice" or portion of the network can be allocated based on the specific needs of the application, use case, or customer. This topology is an essential element of the 5G architectural landscape[6].

- **CU-DU Split**: CU provides support for the higher layers of the protocol stack such as SDAP, PDCP and RRC while DU provides support for the lower layers of the protocol stack such as RLC, MAC and Physical layer. Also, note that SDAP layer will not be present if the CU is connected to a 4G Core network as we should have 5G core network to support SDAP[6].

- **All physical channels including PUCCH Format 1 and 2, excluding Sounding-RS**: In cellular networks, physical channels carry information between the base station (gNB) and user devices (UE). For downlink, the gNB sends data and control information via specific channels (PDCCH for control, PDSCH for data). For uplink, the UE requests resources via PUCCH, gets permission from the gNB (PDCCH), and then sends data (PUSCH)[6].

- **4x4 MIMO**: A 4x4 MIMO system steps things up with four transmitters and four receivers. This allows for up to four "spatially multiplexed" data streams, and a further 30% increase in data speed over 2x2 MIMO. 4x4 MIMO is often found in higher-end WiFi routers and some advanced 4G and 5G devices[6].

- **Support for QAM-256**: 256-QAM is a type of Quadrature Amplitude Modulation (QAM) in which a carrier wave of constant frequency can exist in one of 256 different discrete and measurable states in the constellation plot[6].

- **Highly optimized LDPC and Polar encoder/decoder for ARM Neon and x86 AVX2/AVX512**: Polar codes have lower encoding complexity than LDPC codes, but higher decoding complexity. This is because polar codes use a simple XOR operation to encode but require a complex successive cancellation decoding algorithm to decode it[6].

- **Split 7.2 support using in-house OFH library**: Developed by the SRS team, OFH is an open-source, portable library with minimal 3rd-party dependencies. It has been designed to minimize the integration and configuration burden associated with using srsRAN with 3rd-party O-RUs[6].

- `All RRC procedures <https://embedx.medium.com/mastering-key-rrc-procedures-in-5g-a-visual-breakdown-1c0c0f3f344f>`_

- `All MAC procedures <https://www.linkedin.com/pulse/5g-nr-mac-layer-overview-techlte-world>`_

 
5G NR RRC
---------

RRC is Radio Resource Control. It is a layer 3 protocol used between the UE and the Base station. This protocol is specified by the 3GPP. RRC messages are transported via PDCP (Packet Data Convergence Protocol)[7]. By means of the signaling functions, the RRC configures the user and the control planes according to the network status and it allows for Radio Resource Management strategies that are required to be implemented[7]. RRC parameters should be understood by the network and the UE which can communicate via radio channel. RRC is a layer within the 5G NR protocol stack. RRC (Radio Resource Control) protocol is used on the Air interface. The major functions of the RRC protocol include connection establishment and release functions, broadcast of system information, the establishment of radio bearers, reconfiguration, and release of RRC, paging notification, and releases[1][7]. RRC exists only in the control plane, in the UE, and in the gNB.

The RRC idle mode is known as no connection mode, has the lowest energy consumption. The states in the RRC connected mode, are in order of decreasing power control. The transitions to lower energy consumption states occur when inactivity timers trigger. Different operators have different configurations for the inactivity timers, which leads to differences in energy consumption[4].

In the 5G NR, RRC has three distinct stages:

- RRC_IDLE
- RRC_CONNECTED
- RRC_INACTIVE

.. image:: https://github.com/oran-testing/soft-t-ue/blob/main/docs/images/NR_RRC.png
   :alt: 5G NR RRC

`More on NR RRC <https://www.sharetechnote.com/html/5G/5G_RRC_Overview.html>`_

**Access Stratum (AS) and Non Access Statum (NAS) Signaling in 5G**

.. image:: https://github.com/oran-testing/soft-t-ue/blob/main/docs/images/NAS_AS_Signal.png
   :alt: AS and NAS signal in 5G


In 4G & 5G, the signaling between UE and mobile network can be divided into two types: the Access Stratum (AS) and the Non-Access Stratum (NAS), each responsible for different functions:

1. **Access Stratum (AS)** signalling handles the radio interface and communication between the user equipment (UE) and the radio access network (RAN). It deals with the establishment, maintenance, and termination of radio bearers, which are the logical channels used to transmit user data and control information over the air interface[4]. The main functions of the Access Stratum include:

   - **Radio Resource Control (RRC)**: RRC manages the connection setup and configuration between the UE and the RAN. It controls the radio resources and manages mobility-related procedures, such as handovers between cells[5].
   - **Packet Data Convergence Protocol (PDCP)**: PDCP is responsible for header compression and decompression, as well as ciphering and deciphering the user data packets[3][6].
   - **Radio Link Control (RLC)**: RLC ensures the reliable transmission of user data over the air interface by providing error correction, segmentation, and reassembly of data packets.
   - **Medium Access Control (MAC)**: MAC handles the scheduling and prioritization of data transmission between multiple UEs and the RAN.

2. **Non-Access Stratum (NAS)** signalling handles the signaling and communication between the UE and the core network (CN). It is responsible for controlling the mobility and session management of the UE[1]. The main functions of the Non-Access Stratum include:

   - **Session Management (SM)**: SM handles the establishment, modification, and termination of communication sessions between the UE and the core network. It manages the bearer services and mobility procedures between different access networks[9].
   - **Mobility Management (MM)**: MM is responsible for tracking the UE's location, managing location updates, and handling authentication and security-related procedures during the mobility of the UE[7].
   - **Connection Management (CM)**: CM manages the establishment, modification, and termination of connections between the UE and the core network.

**About the Project - NTIA**

In NTIA project, UE tests the security of srsRAN using srsRAN's UE. In this project, The tester consists of a client PC running the test GUI and a server PC running the base station. (In some cases, a single PC can run both the client and the server.) The client GUI launches a series of applications to run a test. It communicates with the server to indirectly launch server-side applications with appropriate configurations.

Soft_UE_Architecture:

.. image:: https://github.com/oran-testing/soft-t-ue/blob/main/docs/images/soft-t-ue.png
   :alt: Soft_UE_Architecture

GNB Controller Architecture:

.. image:: https://github.com/oran-testing/soft-t-ue/blob/main/docs/images/gnb-controller.png
   :alt: GNB Controller Architecture

UE Controller Architecture:

.. image:: https://github.com/oran-testing/soft-t-ue/blob/main/docs/images/ue-controller.png
   :alt: UE Controller Architecture

Message Architecture:

.. image:: https://github.com/oran-testing/soft-t-ue/blob/main/docs/images/full_message_diagram.png
   :alt: Message Architecture

PDU Session Establishment is the process of establishing a data path between the UE and the 5G core network.


Running the Security Test
-------------------------

This tutorial assumes that you have already installed the srsRAN project and dependencies. The installation procedure can be found `here <https://github.com/oran-testing/soft-t-ue>`_.

Run the SrsRAN Project:

.. code-block:: bash

   cd /opt/srsRAN_Project/docker/ 
   sudo docker compose up --build 5gc     

Run the ZMQ Config file:

.. code-block:: bash

   cd /opt/soft-t-ue/configs
   sudo gnb -c ./gnb_zmq.yaml

Build the file and send the message:

.. code-block:: bash

   cd soft-t-ue/build/
   cmake .. 
   make -j16 
   sudo make install
   cd srsue/src/
   sudo ./srsue ../../../configs/ue_zmq.conf --rrc.sdu_fuzzed_bits 1 --rrc.fuzz_target_message "rrcSetupRequest" 


Running With Multiple UEs over ZMQ
----------------------------------

Open5gs:

.. code-block:: bash

   cd ./srsRAN_Project/docker
   docker compose up --build 5gc

gNB:

.. code-block:: bash

   cd ./srsRAN_Project/build/apps/gnb
   sudo ./gnb -c gnb_zmq.yaml

Net namespaces:

.. code-block:: bash

   sudo ip netns add ue1
   sudo ip netns add ue2
   sudo ip netns add ue3

srsUE:

.. code-block:: bash

   cd ./srsRAN_4G/build/srsue/src
   sudo ./srsue ./ue1_zmq.conf
   sudo ./srsue ./ue2_zmq.conf
   sudo ./srsue ./ue3_zmq.conf

gnb radio:

.. code-block:: bash

   sudo gnuradio-companion ./multi_ue_scenario.grc
