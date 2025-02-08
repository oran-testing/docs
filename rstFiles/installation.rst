===============================
Baremetal (Native) Installation Guide
===============================

.. note:: 

    RAN tester UE is designed to run on Ubuntu and is tested on Ubuntu 24.04.


The following steps outline the process to download and build the RAN Tester UE:

1. Install necessary dependencies
2. Clone the repository
3. Build the code-base

1. Required Build Tools and Dependencies
----------------------------------------

The srsRAN UE system has the following necessary dependencies:

    - `UHD <https://files.ettus.com/manual/page_install.html>`_
    - `ZMQ <https://zeromq.org/download/>`_
    - `boost <https://www.boost.org/doc/libs/release/more/getting_started/index.html>`_
    - `cmake <https://cmake.org/download/>`_
    - `gcc <https://gcc.gnu.org/install/>`_
    - `make <https://www.gnu.org/>` _



To install the above mentioned build tools and other necessary dependencies, run the following:

.. code-block:: bash

  sudo apt update
  sudo apt-get install libzmq3-dev libboost-all-dev cmake gcc g++ make git pkg-config libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev


2. Cloning the repository
-------------------------

To clone the Soft-Tester UE repository, run the following:

.. code-block:: bash

   git clone https://github.com/oran-testing/ran-tester-ue
   cd ran-tester-ue
   git submodule update --init --recursive


3. Building the Code-Base (UE)
------------------------------

To build the code-base, run the following:

.. code-block:: bash

   cd ran-tester-ue
   mkdir -p build
   cd build
   cmake ..
   make -j$(nproc)


Testing against a RAN
----------------------

Go to srsRAN's documentation and follow their tutorial for setting up a gNB, with either ZMQ or UHD. Use the configs from the ran-tester-ue repository, since they are tested to work with our 
modified UE.

- ZMQ configuration files can be found in ran-tester-ue/configs/zmq and UHD configuration files can be found in ran-tester-ue/configs/uhd/multi_ue

.. NOTE::

  Use our subscriber_db.csv file in ran-tester-ue/configs for Open5GS. We recommend the docker compose version. Copy the file to docker/open5gs and modify open5gs.env


Once the RAN is configured correctly run the ue with the following:

.. code-block:: bash

   sudo rtue configs/zmq/ue_zmq.conf

