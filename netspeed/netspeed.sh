#!/bin/bash

ls /sys/class/net 2> /dev/null | while read interface
do
    speed=$(cat /sys/class/net/$interface/speed 2> /dev/null)
    if [[ -z "$speed" ]]; then
        continue
    fi

    # the speed is measured in megabytes
    echo "net,interface=$interface,speed=$speed interface_speed=$speed"
done
