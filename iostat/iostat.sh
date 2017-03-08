#!/bin/bash

# the receiving data in the format: avgrq-sz:await:%util:Device
iostat -dxyk 5 1 | grep . | tail -n +3 | awk '{print $1 " " $8 " " $10 " " $14}' | tr "," "." | while read device avgrq_size await util
do
    # the creating and returning response
    echo "iostat,device=$device avgrq_size_total=$avgrq_size"
    echo "iostat,device=$device await_milliseconds=$await"
    echo "iostat,device=$device util_percents=$util"
done
