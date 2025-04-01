===================
Native Installation
===================

.. note:: 

    RAN Tester UE requires Ubuntu and is officially tested on Ubuntu 24.04 LTS.

1. Install Build Dependencies
*****************************

The srsRAN UE system has the following necessary dependencies:

    - `UHD <https://files.ettus.com/manual/page_install.html>`_
    - `ZMQ <https://zeromq.org/download/>`_
    - `boost <https://www.boost.org/doc/libs/release/more/getting_started/index.html>`_
    - `cmake <https://cmake.org/download/>`_
    - `gcc <https://gcc.gnu.org/install/>`_
    - `make <https://www.gnu.org/>`_

.. code-block:: bash

    sudo apt-get update && sudo apt-get install -y cmake gcc g++ make libzmq3-dev libboost-all-dev \
        libuhd-dev uhd-host pkg-config libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev
        

2. Clone Repository
*******************

Clone the RAN Tester UE repository with submodules:

.. code-block:: bash

    git clone --recurse-submodules https://github.com/oran-testing/ran-tester-ue


3. Build from Source
********************

Compile and install the software:

.. code-block:: bash

    cd ran-tester-ue
    mkdir build && cd build
    cmake ../
    make -j $(nproc)
    sudo make install


Testing against a RAN
*********************

Refer to `srsRAN's documentation <https://docs.srsran.com/projects/project/en/latest/index.html>`_ for setting up a gNB with ZMQ or UHD. Use our pre-tested configs:

- ZMQ files: `ran-tester-ue/configs/zmq`
- UHD files: `ran-tester-ue/configs/uhd/multi_ue`


.. note::

   Use the `subscriber_db.csv` in `ran-tester-ue/configs` for Open5GS. We recommend the Docker Compose version. Copy it to ``docker/open5gs`` and modify **open5gs.env**.
