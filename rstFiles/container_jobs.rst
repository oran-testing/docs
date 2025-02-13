Architecture Overview
===================

Controller
----------

-  Start processes
-  Monitor process status
-  Log errors and process logs
-  Send process logs to InfluxDB
-  Configure data dumps
-  Maintain and establish correct process environment
-  Manages application lifecycle
-  Handles on time start and terminate

rtUE
-----

-  Run attacks
-  Send metrics directly to InfluxDB

Uu agent
--------

-  Man-in-the-middle / sniffing / spoofing
-  Run independent Uu attacks
-  Send metrics to InfluxDB

Jammer
------

-  Run jamming attacks flexibly
-  Send data to InfluxDB

Channel Sounder
---------------

-  Send IQ and PHY data to InfluxDB


InfluxDB
--------

-  Store data in real-time
-  Facilitate CSV and DB data dumps
-  Send metrics to Grafana

Grafana
-------

-  Display metrics in a simple format
