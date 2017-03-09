# FD plugin

FD plugin provides metrics about file descriptors utilization for process in the docker and supervistor systems. 
All metrics are extracted by reading `/proc/PID/limits` and `/proc/PID/fd` files. 

Plugin works only on Linux systems.

## Measurements

- `proc_open_files_total` - number of open file descriptors by process
- `proc_open_files_limit` - limit of open file descriptors for process
- `proc_number` - number of processes, for which  metrics `proc_open_files_total` and `proc_open_files_limit` will be collected

## Dependencies

No dependencies. If docker system is not installed, no metrics will be collected. The same for the supervisor system.

## Configuration

```
[[inputs.exec]]
  commands = ["/path/to/plugin/fd.sh"]
  timeout = "5s"
  data_format = "influx"
```

## Output example

```
fd,process=nginx proc_open_files_total=2012
fd,process=nginx proc_open_files_limit=65536
fd,process=php-fpm proc_open_files_total=65
fd,process=php-fpm proc_open_files_limit=65536
fd,system=docker proc_number=2
fd,system=supervisor proc_number=83
```
