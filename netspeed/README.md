# NETSPEED plugin

NETSPEED plugin provides metrics about speed of network interfaces. 
All metrics are extracted by reading `/sys/class/net` directory.

Plugin works only on Linux systems.

## Measurements

- `interface_speed` - speed of network interface

## Dependencies

No dependencies.

## Configuration

```
[[inputs.exec]]
  commands = ["/path/to/plugin/netspeed.sh"]
  timeout = "5s"
  data_format = "influx"
```

## Output example

```
net,interface=eno1,speed=1000 interface_speed=1000
net,interface=ens1f0,speed=10000 interface_speed=10000
```
