#!/usr/bin/env bash

# outputs metric data
function output_metric {
    while read total limit process; do
        echo "fd,process=$process proc_open_files_total=$total"
        echo "fd,process=$process proc_open_files_limit=$limit"
    done
}

# outputs number of pids
function output_pids_number {
    echo "fd,system=docker proc_number=$1"
    echo "fd,system=supervisor proc_number=$2"
}

# loads the limit of process by PID
function load_limit {
    echo $(cat /proc/$1/limits 2> /dev/null | awk '($2=="open") && ($3=="files")  {print $4}')
}

# loads count of created descriptors by PID
function load_total {
    echo $(sudo /bin/ls /proc/$1/fd/ 2> /dev/null | wc -l)
}

# loads limit and total of process and returns them with process name
function load_metric {
    process_name=$(basename $(awk '-F\0' '{print $1}' < "/proc/$pid/cmdline"))
    # if the process name is shell, skip it
    if [[ $process_name = "sh" ]]; then
        return 0
    fi

    limit=$(load_limit $pid)
    # if it is not number, skip it
    re='^[0-9]+$'
    if ! [[ $limit =~ $re ]] ; then
        return 0
    fi

    total=$(load_total $pid)

    echo "$total $limit $process_name"
}

# loads and returns list of pid from supervisor
function load_pids_from_supervisorctl {
    sudo /usr/bin/supervisorctl status | awk '{print $4}' | sed 's/,//g' | while read pid; do
        re='^[0-9]+$'
        if ! [[ $pid =~ $re ]] ; then
            continue
        fi
        echo $pid
    done
}

# loads and returns list of pid from docker
function load_pids_from_docker {
    sudo /usr/bin/docker ps -q --no-trunc 2> /dev/null | while read container_id; do
        pids=$(cat "/sys/fs/cgroup/pids/docker/$container_id/cgroup.procs" 2> /dev/null)

        for pid in $pids
        do
            echo "$container_id,$pid"
        done
    done
}

# initialize vars for docker and supervisor pids
pids_from_supervisorct=""
pids_from_docker=""

# if there is a docker system, then outputs metrics for processes from supervisor
if [[ -x "/usr/bin/supervisorctl" ]]
then
    # load pids from supervisor
    pids_from_supervisorctl=$(load_pids_from_supervisorctl)

    # loads and outputs file descriptors metrics for processes, which were launched by supervisor
    echo "$pids_from_supervisorctl" | while read pid; do
        re='^[0-9]+$'
        if ! [[ $pid =~ $re ]] ; then
            continue
        fi

        metric=$(load_metric $pid)
        if [ -z "$metric" ]
        then
            continue
        fi

        echo "$metric"
    done | output_metric
fi

# if there is a supervisor system, then outputs metrics for processes from docker
if [[ -x "/usr/bin/docker" ]]
then
    # load pids from docker
    pids_from_docker=$(load_pids_from_docker)

    # loads and outputs file descriptors metrics for processes, which are located in the docker containers
    echo "$pids_from_docker" | while read proc_data; do
        IFS=', ' read -r -a  proc_data_arr <<< "$proc_data"
        container_id="${proc_data_arr[0]}"
        pid="${proc_data_arr[1]}"

        service_name=$(sudo /usr/bin/docker inspect $container_id 2> /dev/null | awk '-F=|"' '$2 == "APP" {print $3}')
        if [[ -z "$service_name" ]]; then
            continue
        fi

        metric=$(load_metric $pid)
        if [ -z "$metric" ]
        then
            continue
        fi

        echo "$metric"
    done | sort -k1nr | output_metric
fi

pid_number_from_supervisorctl=$(echo $pids_from_supervisorctl | wc -w)
pid_number_from_docker=$(echo $pids_from_docker| wc -w)
# outputs number of pids
output_pids_number $pid_number_from_supervisorctl $pid_number_from_docker
