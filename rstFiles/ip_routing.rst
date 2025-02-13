IP Routing
=============

Routing configuration
---------------------

**On the gNB machine:**

.. code:: bash

 sudo ip ro add 10.45.0.0/16 via 10.53.1.2
 ping 10.45.1.2 # check downlink connection

Note that all UE network commands must be run inside **netns ue1** if you are running the UE with ZMQ on one machine.

**Inside the UE container:**

First, find the IP of the **tun_rtue** interface:

.. code:: bash

  ifconfig tun_rtue


Then, create a route through the iface:

.. code:: bash

 ip ro add 10.53.0.0/16 via <iface ip> dev tun_rtue
 ping 10.53.1.1 # check uplink connection


Running Iperf
-------------

**On the gNB machine:**

.. code:: bash

 iperf3 -s -i 1 -p <some unused port>

**Inside the UE container:**

You can send either TCP or UDP traffic at the desired bitrate:

.. code:: bash

 # TCP
 iperf3 -c 10.53.1.1 -i 1 -t 60 -p <some unused port>
 # or UDP
 iperf3 -c 10.53.1.1 -i 1 -t 60 -u -b 10M -p <some unused port>

