Overview
===========

This project provides a GUI enabling users to run a series of white-box and
black-box tests on the srsRAN gNodeB.

Setup
-----

To set up this project (currently, for ZeroMQ):

1. Install the required build tools for the srsRAN 4G and the
   `srsRAN project <https://docs.srsran.com/projects/project/en/latest/user_manuals/source/installation.html#manual-installation>`_.

   For Ubuntu:

   .. code-block:: bash

       sudo apt-get install cmake make gcc g++ pkg-config libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev
       sudo apt-get install libzmq3-dev
       sudo apt install net-tools libboost-all-dev libconfig++-dev iperf3 git libxcb-cursor0 libgles2-mesa-dev

2. `Build <https://docs.srsran.com/projects/project/en/latest/tutorials/source/srsUE/source/index.html#id3>`_
   the srsRAN project with ZeroMQ enabled. Also follow the last few steps of
   the general installation
   `instructions <https://docs.srsran.com/projects/4g/en/latest/general/source/1_installation.html#gen-installation>`_.

   Overall:

   .. code-block:: bash

       git clone https://github.com/oran-testing/srsRAN_Project.git
       cd srsRAN_Project
       git checkout ue-tester
       mkdir build
       cd build
       cmake ../ -DENABLE_EXPORT=ON -DENABLE_ZEROMQ=ON
       make -j $(nproc)
       make test -j $(nproc)
       sudo make install

3. `Build <https://docs.srsran.com/projects/4g/en/latest/app_notes/source/zeromq/source/index.html>`_
   the srsRAN 4G with ZeroMQ enabled.

   Specifically:

   .. code-block:: bash

       git clone https://github.com/oran-testing/srsRAN_4G.git
       cd srsRAN_4G
       git checkout ue-tester
       mkdir build
       cd build
       cmake ../
       make -j $(nproc)
       make test
       sudo make install
       srsran_install_configs.sh user

4. Install `Docker <https://docs.docker.com/desktop/install/linux-install/>`_.

5. Build the Open5G
   core `Docker image <https://docs.srsran.com/projects/project/en/latest/tutorials/source/srsUE/source/index.html#open5gs-core>`_

   .. code-block:: bash

       cd srsRAN_Project/docker
       docker compose build

6. Perform network setup:

   .. code-block:: bash

       sudo ip netns add ue1
       sudo ip netns list


Running
-------

To run this project (ZeroMQ):

1. `Run <https://docs.srsran.com/projects/project/en/latest/tutorials/source/srsUE/source/index.html#open5gs-core>`_ the Open5G core:

   .. code-block:: bash

      cd srsRAN_Project/docker
      docker compose up 5gc

2. Run gNodeB:

   .. code-block:: bash

      cd srsRAN_Project
      sudo gnb -c configs/gnb_zmq.yaml

3. Run the UE:

   .. code-block:: bash

      cd srsRAN_4G/build
      sudo srsue ~/.config/srsran/ue.conf

4. Perform more `network setup <https://docs.srsran.com/projects/4g/en/latest/app_notes/source/zeromq/source/index.html#network-namespace-creation>`_ (one-time setup):

   .. code-block:: bash

      sudo ip ro add 10.45.0.0/16 via 10.53.1.2
      route -n
      sudo ip netns exec ue1 ip route add default via 10.45.1.1 dev tun_srsue
      sudo ip netns exec ue1 route -n

5. Do stuff.

   a. On the server:

      .. code-block:: bash

         docker compose exec 5gc bash
         iperf3 -s -i 1

   b. On the client:

      .. code-block:: bash

         sudo ip netns exec ue1 iperf3 -c 10.45.1.1 -i 1 -t 60


Software development plan
-------------------------

1. Use Python, running on the UE, to script everything.
2. Use PyQt6 as a GUI.
3. To prepare the system, open a series of terminals; use asyncio to stream
   data while also updating GUI.

   a. Run the open 5G core.
   b. When it's up, run gNodeB.
   c. When it's up, run the 4G UE.
   d. When it's up, run iperf -s in the 5G core container. (Perhaps several,
      one for each UE.)
   e. When it's up, run iperf --json on the client. Listen to JSON data then
      graph.

4. Write a Python-based install script to download/install the entire system
   from a single command.


Python setup
------------

1. `Install <https://python-poetry.org/docs/#installation>`_ Poetry.
2. Install this application:

   .. code-block:: bash

      cd srsRAN_4G/ue-tester
      poetry install

3. Run the program:

   .. code-block:: bash

      poetry run python ue_tester.py

Links
-----

- `5G | ShareTechnote <https://sharetechnote.com/html/5G/Handbook_5G_Index.html>`_
- `LTE Tutorials - YouTube <https://www.youtube.com/playlist?list=PLstYdSyXDHhYrhkVIU_kUBTYXQSqO_sfL>`_
