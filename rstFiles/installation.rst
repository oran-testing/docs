============
Baremetal Installation
============

.. note:: 

    RAN tester UE is designed to run on Ubuntu and is tested on Ubuntu 24.04.


Build Tools and Dependencies
----------------------------

The srsRAN UE system has the following necessary dependencies. Please install them beforehand.

    - `UHD <https://files.ettus.com/manual/page_install.html>`_
    - `ZMQ <https://zeromq.org/get-started/>`_
    - `boost <https://www.boost.org/doc/libs/release/more/getting_started/index.html>`_
    - `cmake <https://cmake.org/install/>`_
    - `gcc <https://gcc.gnu.org/install/>`_
    - `make <https://www.gnu.org/software/make/>`_


Building the UE
-------------------

Clone Soft-Tester UE repository:

.. code-block:: bash

   git clone https://github.com/oran-testing/ran-tester-ue && git submodule update --init --recursive

Then run cmake to install (linux only):

.. code-block:: bash

   cd ran-tester-ue
   mkdir -p build
   cd build
   cmake ..
   make -j$(nproc)


Testing against a RAN
--------------------

Go to srsRAN's documentation and follow their tutorial for setting up a gNB, with either ZMQ or UHD. Use the configs from the ran-tester-ue repository, since they are tested to work with our 
modified UE.

- ZMQ configuration files can be found in ran-tester-ue/configs/zmq and UHD configuration files can be found in ran-tester-ue/configs/uhd/multi_ue

.. NOTE::

  Use our subscriber_db.csv file in ran-tester-ue/configs for Open5GS. We recommend the docker compose version. Copy the file to docker/open5gs and modify open5gs.env


Once the RAN is configured correctly run the ue with the following:

.. code-block:: bash

   sudo rtue configs/zmq/ue_zmq.conf

