# TOP plugin

TOP plugin provides metrics about top 5 processes by CPU and memory usage. 
All metrics are extracted from `top` and `ps` command.

Plugin works only on Linux systems.

## Measurements

- `cpu_usage_percent` - CPU usage in percents by cores. Value: `0 .. 100 * cores_num`
- `memory_usage_percent` - CPU usage in percents. Value: `0..100`

## Dependencies

No dependencies - plugin uses `top` and `ps` as data source.

## Configuration

```
[[inputs.exec]]
  commands = ["/path/to/plugin/top.sh"]
  timeout = "5s"
  data_format = "influx"
```

## Output example

```
proc,process=top cpu_usage_percent=1.2
proc,process=zabbix_agentd cpu_usage_percent=1.3
proc,process=writeback cpu_usage_percent=2
proc,process=mcollectived cpu_usage_percent=14.3
proc,process=prometheus cpu_usage_percent=57.2
proc,process=unbound memory_usage_percent=0.1
proc,process=docker memory_usage_percent=0.2
proc,process=mcollectived memory_usage_percent=0.4
proc,process=systemd-journal memory_usage_percent=0.4
proc,process=prometheus memory_usage_percent=7.6
```
