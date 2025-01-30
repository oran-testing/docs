Type: master

Controller
----------

-  Start processes
-  Monitor process status
-  Log errors and process logs
-  Send process logs to influxdb
-  Configure data dumps
-  Maintain and establish correct process environment
-  Manages application lifecycle
-  Handles on time start and terminate

Make standardized interface for components

Type: subprocess containers

srsUE
-----

-  Run attacks
-  Send metrics directly to influxdb

Uu agent
--------

-  Man in the middle / sniffing / spoofing
-  Run independent Uu attacks
-  Send metrics to InfluxDB

jammer
------

-  Run jamming attacks flexibly
-  Send data to InfluxDB

Channel Sounder
---------------

-  Send IQ and PHY data to InfluxDB

Type: optional data display and management

influxdb
--------

-  Store data in realtime
-  Facilitate CSV and DB data dumps
-  Send metrics to Grafana

Grafana
-------

-  Display metrics in a simple format

NOTE: Protected RACH PAPER: DURIP lab as service Ansible (replace GitHub CI/CD)
