Software Tester UE
==================

Overview
--------

The tester UE can be used on its own or with the python controller and
GUI.

Modified srsRAN User Equipment
------------------------------

To install the customized srsRAN UE:

.. code:: bash

   mkdir build && cd build
   cmake ..
   make -j$(nproc)
   sudo make install

Attacks are started through the MCP server via ``start_component``, not by passing arguments to the UE directly:

- :doc:`5G Sniffer <../attacks/5g_sniffer>`
- :doc:`SSB Spoofing Attack <../attacks/ssb_spoofing>`
- :doc:`Signaling Storm Injection Attack <../attacks/signal_storming>`
- :doc:`Fronthaul Packet Replay <../attacks/fronthaul_packet_replay>`


Python Controller and Graphical User Interface
----------------------------------------------

To run the controller:

.. code:: bash

   cd controller/ue
   python3 main.py

Controller arguments: ``python3 main.py -h –config /path/to/config –gnb_config /path/to/gnb_config –ip IP –port PORT``

Run an srsRAN gNB and Open5GS, then send metrics to the ue_controller

.. code:: bash

	options:
		-h, --help
		--config PATH (default: ../../configs/basic_ue_zmq.yaml)
		--gnb_config PATH (default: ../../configs/zmq/gnb_zmq.conf)
		--ip IP (default: 127.0.0.1)	#IP used to communicate with gNB controller
		--port PORT (default: 5000)	#Port used to communicate with gNB controller


Configuring the UE
------------------

.. deprecated::
   The Python controller with ``processes:`` is **deprecated**. Attacks are now configured and started through the MCP server using ``start_component`` with JSON config payloads. See the :doc:`5G Sniffer <../attacks/5g_sniffer>` page for an example.

The legacy Python controller reads a yaml config file with the following structure:

.. code:: bash

	#YAML config structure (deprecated)
	gnb:
		- config: str
	namespaces:
		- name: str
	processes:
		- type: clean | tester | jammer | ...
		- config_file: str
		- args: str (optional)

**Example configuration files**:

- `basic_ue_zmq.yaml <https://raw.githubusercontent.com/oran-testing/soft-t-ue/ue_redesign/configs/basic_ue_zmq.yaml>`__
- `multi_ue_zmq.yaml <https://raw.githubusercontent.com/oran-testing/soft-t-ue/ue_redesign/configs/multi_ue_zmq.yaml>`__
