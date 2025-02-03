Jamming Attack
==========================================================

Introduction
-------------
Jamming is the intentional disruption of a wireless signal by transmitting a strong interference on the same frequency, blocking or degrading the intended communication.
Currently, there are 4 main jamming methods `[1] <https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5343062>`_ :

1. Spot Jamming
2. Sweep Jamming
3. Barrage Jamming
4. Deceptive Jamming

In our system, we have currently implemented Spot Jamming, where all malicious transmission power is directed at a single frequency used by the target, utilizing the same modulation and sufficient power to override the original signal.

Adding to your test
------------------

In your controller config, located in docker/controller/configs/ add the following to the processes list:

.. code-block:: yaml

   processes:
    - type: "jammer"
      config_file: "configs/basic_jammer.yaml"
 
Attack Metrics
----------------
- Inability of UEs to connect
- Low channel quality
- gNB overload /crash
- UE detach
