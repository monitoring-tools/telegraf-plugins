 IOSTAT plugin

IOSTAT plugin provides metrics about I/O utilization. 
All metrics are extracted from `iostat` command.

Plugin works only on Linux systems.

## Measurements

- `avgrq_size_total` - average queue size
- `await_milliseconds` - average request time in milliseconds
- `util_percents` - I/O utilization in percents (0..100)

## Dependencies

`iostat` MUST be installed to use this plugin.

## Configuration

```
[[inputs.exec]]
  commands = ["/path/to/plugin/iostat.sh"]
  timeout = "5s"
  data_format = "influx"
```

## Output example

```
iostat,device=vda avgrq_size_total=374.29
iostat,device=vda await_milliseconds=22.59
iostat,device=vda util_percents=1.20
```
