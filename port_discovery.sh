#!/bin/bash

while read host; do
    echo "[*] Scanning $host" | tee -a live_hosts_openports.txt
    for port in {1..1000}; do
        timeout 0.1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null && echo "[+] Port $port open" | tee -a live_hosts_openports.txt
    done
done < live_hosts.txt
