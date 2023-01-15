#!/bin/bash

subnet=$1

if [ ! -f live_hosts.txt ]; then 
	touch live_hosts.txt 
fi

for i in {1..255}
do
    ip="${subnet}.${i}"
    ping -c 1 $ip > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "[+] $ip is online"
        echo $ip >> live_hosts.txt
    fi
done
