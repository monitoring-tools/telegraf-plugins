# NETSTAT plugin

NETSTAT plugin provides metrics about TCP connections and UDP sockets.
All metrics are extracted from `ss` command.

> Telegraf already has built-in [NETSTAT](https://github.com/influxdata/telegraf/blob/master/plugins/inputs/system/NETSTAT_README.md) plugin.
> But built-in plugin produces too much system calls and consumes up to 20% of total CPU even on modern servers.


Output of this plugin is completely compatible with built-in Telegraf NETSTAT plugin.

Plugin works only on Linux systems.

## Measurements

- `udp_socket` - UDP sockets count
- `tcp_established` - Established TCP connections count
- `tcp_syn_sent` - Connections waiting for an acknowledgment from the remote endpoint
- `tcp_syn_recv` - Connections that have received a connection request and sent an acknowledgment
- `tcp_fin_wait1` - Connections waiting for an acknowledgment of the connection termination request
- `tcp_fin_wait2` - Connections waiting for a connection termination request from the remote TCP
- `tcp_time_wait` - Connections waiting for enough time to pass to be sure the remote TCP received the acknowledgment of its connection termination request
- `tcp_close` - Represents no connection state at all
- `tcp_close_wait` - Connections waiting for a connection termination request from the local application
- `tcp_last_ack` - Connections waiting for an acknowledgment of the connection termination request previously sent to the remote TCP
- `tcp_listen` - Connections waiting for a connection request from a remote TCP application
- `tcp_closing` - Connections waiting for a connection termination request acknowledgment from the remote TCP

## Dependencies

`ss` MUST be installed to use this plugin.

## Configuration

```
[[inputs.exec]]
  commands = ["/path/to/plugin/netstat.sh"]
  timeout = "5s"
  data_format = "influx"
```

## Output example

```
netstat udp_socket=10
netstat tcp_established=2
netstat tcp_syn_sent=0
netstat tcp_syn_recv=0
netstat tcp_fin_wait1=0
netstat tcp_fin_wait2=0
netstat tcp_time_wait=9
netstat tcp_close=0
netstat tcp_close_wait=0
netstat tcp_last_ack=0
netstat tcp_listen=11
netstat tcp_closing=0
```
