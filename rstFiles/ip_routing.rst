IP Routing Configuration
========================

gNB Machine Setup
^^^^^^^^^^^^^^^^^
1. Add downlink route to UE network:

   .. code-block:: bash

    sudo ip route add 10.45.0.0/16 via 10.53.1.2
    ping 10.45.1.2  # Verify downlink connection

.. important:: 
    For single-machine ZMQ setups, prepend all UE network commands with ``ip netns exec ue1``

UE Container Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^
1. Identify TUN interface IP:

   .. code-block:: bash

    ifconfig tun_rtue | grep 'inet addr'

2. Establish uplink routing:

   .. code-block:: bash

    ip route add 10.53.0.0/16 via <tun_rtue_ip> dev tun_rtue
    ping 10.53.1.1  # Validate uplink connection

**************************
iPerf3 Performance Testing
**************************

Server side (gNB)
^^^^^^^^^^^^^^^^^
.. code-block:: bash

    iperf3 -s -i 1 -p <port_number>

Client side (UE Container)
^^^^^^^^^^^^^^^^^^^^^^^^^^
.. code:: bash

 # TCP
 iperf3 -c 10.53.1.1 -i 1 -t 60 -p <port_number>
 # UDP
 iperf3 -c 10.53.1.1 -i 1 -t 60 -u -b 10M -p <port_number>
