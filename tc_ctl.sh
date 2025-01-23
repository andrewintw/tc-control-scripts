#! /bin/sh

if ! command -v tc &> /dev/null
then
    echo "INFO> tc is not installed. Please install iproute2 with: sudo apt install iproute2"
    exit 1
fi

usage() {
	echo
    echo "Usage: $0 <{rate} | del | show>"
    echo "  rate : Apply a rate limit (in kbit) to eth0. Example: $0 20 (for 20kbit)"
    echo "  del  : Delete the traffic control settings on eth0"
    echo "  show : Show the current traffic control settings on eth0"
	echo
    exit 1
}

# 刪除流量控制設定
clear_tc_settings() {
    echo "INFO> Deleting traffic control settings on eth0..."
    tc qdisc del dev eth0 root 2>/dev/null
}

# 顯示當前的流量控制設定
show_tc_settings() {
    tc qdisc show dev eth0
}

case "$1" in
    [0-9]*)
        RATE="$1"
        echo "INFO> Applying $RATE kbit rate limit to eth0..."
        clear_tc_settings
        tc qdisc add dev eth0 root handle 1: htb default 10
        tc class add dev eth0 parent 1: classid 1:1 htb rate ${RATE}kbit ceil ${RATE}kbit
        tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst 0.0.0.0/0 flowid 1:1
        show_tc_settings
        ;;
    del)
        clear_tc_settings
		show_tc_settings
        ;;
    show)
        show_tc_settings
        ;;
    -h|*)
        usage
        ;;
esac

