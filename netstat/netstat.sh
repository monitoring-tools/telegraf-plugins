#!/bin/bash
# outputs counts of UDP sockets
ss -u -a -n | awk 'END{print "netstat udp_socket=" NR-1}'
# outputs counts of TCP connections states
ss -t -a -n | awk 'BEGIN {
    # initialization array of counts by states
    arr["ESTAB"] = 0
    arr["SYN-SENT"] = 0
    arr["SYN-RECV"] = 0
    arr["FIN-WAIT-1"] = 0
    arr["FIN-WAIT-2"] = 0
    arr["TIME-WAIT"] = 0
    arr["UNCONN"] = 0
    arr["CLOSE-WAIT"] = 0
    arr["LAST-ACK"] = 0
    arr["LISTEN"] = 0
    arr["CLOSING"] = 0
    arr["UNKNOWN"] = 0
}
NR > 1 {
    # increase counts of states
    arr[$1]+=1
}
END {
    # output counts of states
    print "netstat tcp_established="arr["ESTAB"]
    print "netstat tcp_syn_sent="arr["SYN-SENT"]
    print "netstat tcp_syn_recv="arr["SYN-RECV"]
    print "netstat tcp_fin_wait1="arr["FIN-WAIT-1"]
    print "netstat tcp_fin_wait2="arr["FIN-WAIT-2"]
    print "netstat tcp_time_wait="arr["TIME-WAIT"]
    print "netstat tcp_close="arr["UNCONN"]
    print "netstat tcp_close_wait="arr["CLOSE-WAIT"]
    print "netstat tcp_last_ack="arr["LAST-ACK"]
    print "netstat tcp_listen="arr["LISTEN"]
    print "netstat tcp_closing="arr["CLOSING"]
    print "netstat tcp_none="arr["UNKNOWN"]
}'