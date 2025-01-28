Jamming Attack
==========================================================

Introduction
-------------
Jamming is the intentional disruption of a wireless signal by transmitting a strong interference on the same frequency, blocking or degrading the intended communication.
Currently, there are 4 main jamming methods :sup:`[2] <https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5343062>`_ :

1. Spot Jamming
2. Sweep Jamming
3. Barrage Jamming
4. Deceptive Jamming

In our system, we are implementing Spot Jamming, where all malicious transmission power is directed at a single frequency used by the target, utilizing the same modulation and sufficient power to override the original signal.


Implementation (UE)
--------------------------

- Transmit a higher volume of RACH messages
- Configure UE to transmit at a higher gain

Attack Metrics
----------------
- Inability of UEs to connect
- Low channel quality
- gNB overload /crash
