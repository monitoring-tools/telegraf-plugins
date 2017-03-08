#!/bin/bash

top -n1 -b | tail -n +8 | awk '{arr[$12]+=$9} END {for (i in arr) {print i,arr[i]}}' | sort -n -k 2,2 | awk '{print "proc,process=" $1 " cpu_usage_percent=" $2}' | tail -5
ps axco command,pmem --no-headers | awk '{arr[$1]+=$2} END {for (i in arr) {print i,arr[i]}}' | sort -n -k 2,2 | awk '{print "proc,process=" $1 " memory_usage_percent=" $2}' | tail -5
