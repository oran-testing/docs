Software Tester UE
===================

Overview
---------

The tester UE can be used on its own or with the python controller and
GUI.

Modified srsRAN User Equipment
------------------------------

To Install the customized srsRAN UE:

.. code:: bash

   mkdir build && cd build
   cmake ..
   make -j$(nproc)
   sudo make install

The UE can be passed arguments described in the following pages to run
various attacks: -

- :doc:`CQI Manipulation Attack <../attacks/cqi_manipulation>`
- :doc:`gNB Impersonation Attack <../attacks/gnb_impersonation_attack>`
- :doc:`IMSI Catching Attack <../attacks/imsi_capture>`
- :doc:`Preamble Collision Attack <../attacks/preamble_collision>`
- :doc:`RACH Jamming Attack <../attacks/rach_jamming>`
- :doc:`RACH Replay Attack <../attacks/rach_replay>`
- :doc:`RACH Signal Flooding Attack <../attacks/rach_signal_flooding>`
- :doc:`RoHC Poisoning Attack <../attacks/rohc_poisoning_attack>`
- :doc:`Signaling Storm Injection Attack <../attacks/signal_storming>`
- :doc:`PDCP message Parroting Attack <../attacks/pdcpParrot>`
- :doc:`RRC Release Request Spoofing Attack<../attacks/request_spoofing>`
- :doc:`SDU Fuzzing Attack <../attacks/sdu_fuzzing>`


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
-------------------

The UE controller reads a yaml config file with the following options:

.. code:: bash
	
	#YAML config structure
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
