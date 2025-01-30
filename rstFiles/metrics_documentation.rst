srsRAN UE metrics send to influxDB
==================================

Singleton Metrics
-----------------

These metrics are independent of specific carriers and provide
system-wide or UE-wide information.

Metrics
~~~~~~~

-  :bold-point:`rf_o`: RF front-end overflows. Indicates how many times the RF
   front-end buffer overflowed.
-  :bold-point:`rf_u`: RF front-end underflows. Indicates how many times the
   RF front-end buffer underflowed.
-  :bold-point:`rf_l`: RF front-end late samples. Indicates the number of late
   samples received by the RF front-end.

-  :bold-point:`nof_active_cc`: Number of active component carriers. The
   maximum of LTE and NR active component carriers.

-  :bold-point:`dl_tput_mbps`: Downlink throughput in Mbps. Measures the data
   rate received by the UE.
-  :bold-point:`ul_tput_mbps`: Uplink throughput in Mbps. Measures the data
   rate transmitted by the UE.

-  :bold-point:`ul_dropped_sdus`: Number of uplink SDUs (Service Data Units)
   dropped by the stack.
-  :bold-point:`nof_active_eps_bearer`: Number of active EPS (Evolved Packet
   System) bearers.
-  :bold-point:`emm_state`: EMM (EPS Mobility Management) state. Reflects the
   current state of the UE in the EMM state machine.

-  :bold-point:`proc_rmem`: Real memory usage of the process in bytes.
-  :bold-point:`proc_rmem_kB`: Real memory usage of the process in kilobytes.
-  :bold-point:`proc_vmem_kB`: Virtual memory usage of the process in
   kilobytes.
-  :bold-point:`sys_mem`: Total system memory usage in bytes.
-  :bold-point:`system_load`: CPU usage of the process as a percentage of the
   total CPU.

--------------

Carrier-Specific Metrics
------------------------

These metrics are collected for each active carrier, including both LTE
and NR carriers. The carrier type (LTE or NR) and channel index are
specified.

.. _metrics-1:

Metrics
~~~~~~~

-  :bold-point:`dl_earfcn`: Downlink EARFCN (E-UTRA Absolute Radio Frequency
   Channel Number). Indicates the frequency used by the carrier.
-  :bold-point:`pci`: Physical Cell ID. Identifies the cell from which the
   signal is received.

-  :bold-point:`rsrp`: Reference Signal Received Power (RSRP). Measures the
   power level of the reference signal.
-  :bold-point:`pathloss`: Path loss. Represents the loss of signal power due
   to propagation.
-  :bold-point:`cfo`: Carrier frequency offset. Indicates the frequency offset
   between the received signal and the expected carrier frequency.

-  :bold-point:`rl_mcs`: Uplink modulation and coding scheme (MCS).
-  :bold-point:`dl_mcs`: Downlink modulation and coding scheme (MCS).
-  :bold-point:`sinr`: Signal-to-Interference-plus-Noise Ratio (SINR).
   Represents the quality of the signal. If infinite, it is set to
   ``0``.
-  :bold-point:`fec_iters`: Number of forward error correction (FEC)
   iterations performed.

-  :bold-point:`rx_brate`: Received bit rate in Kbps. Computed as the average
   bit rate over the number of TTI (Transmission Time Intervals).
-  :bold-point:`tx_brate`: Transmitted bit rate in Kbps. Computed as the
   average bit rate over the number of TTIs.

-  :bold-point:`rx_pkts`: Total number of received packets.
-  :bold-point:`rx_errors`: Total number of receive errors.
-  :bold-point:`tx_pkts`: Total number of transmitted packets.
-  :bold-point:`tx_errors`: Total number of transmit errors.

-  :bold-point:`ta_us`: Timing advance in microseconds. Represents the time
   alignment between the UE and eNodeB/gNodeB.
-  :bold-point:`distance_km`: Estimated distance to the cell in kilometers.
-  :bold-point:`speed_kmph`: Speed of the UE in kilometers per hour.
-  :bold-point:`ul_buffer`: Size of the uplink buffer in bytes.

-  :bold-point:`rrc_state`: RRC (Radio Resource Control) state. Indicates the
   current state of the RRC state machine.

--------------

Notes
-----

-  Metrics are posted to the InfluxDB server using the HTTP API.
-  Errors returned from InfluxDB are logged to the console.
-  The timestamp for each metric is derived from the system’s epoch time
   in nanoseconds.

Improvements and Future Work
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Neighboring cell metrics (e.g., neighbor cell RSRP) can be added in
   the future.
-  Metrics differentiation for multiple UEs should be implemented.