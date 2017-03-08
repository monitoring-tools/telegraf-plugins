# Plugins for Telegraf

Here you can find some useful third-party plugins for Telegraf:
- [IOSTAT](https://github.com/monitoring-tools/telegraf-plugins/tree/master/iostat) - I/O utilization and other information from iostat
- [NETSTAT](https://github.com/monitoring-tools/telegraf-plugins/tree/master/netstat) - TCP connections statuses and UDP sockets count
- [TOP](https://github.com/monitoring-tools/telegraf-plugins/tree/master/top) - resource usage by top processes

All plugins are tested and production-ready. 

## Installation

1. Copy plugin to server where Telegraf is running
2. Add plugin to Telegraf config as [exec plugin](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/exec)
3. Restart Telegraf

Please, note that plugins works only on Linux systems.

## About Telegraf

Telegraf is an agent written in Go for collecting, processing, aggregating, and writing metrics.

Telegraf official repository: https://github.com/influxdata/telegraf
