Type: master

## Controller

- start processes
- monitor process status
- log errors and process logs
- send process logs to influxdb
- configure data dumps
- maintain and establish correct process environment
- manages application lifecycle
- handles on time start and terminate

Make standardized interface for components

Type: subprocess containers

## srsue

- run attacks
- send metrics directly to influxdb

## UU agent

- man in the middle / sniffing / spoofing
- run independent UU attacks
- send metrics to influxdb

## jammer

- run jamming attacks flexibly
- send data to influxdb

## Channel Sounder

- send IQ and PHY data to influxdb

Type: optional data display and management

## influxdb

- store data in realtime
- facilitate CSV and DB data dumps
- send metrics to grafana

## grafana

- Display metrics in a simple format

NOTE: Protected RACH
PAPER: DURIP lab as service ansible (replace github ci cd)
