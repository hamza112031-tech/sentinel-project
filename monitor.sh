#!/bin/bash
monitor_system() {
 echo "=== System Monitor ==="
 cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
 echo "CPU usage: $cpu%"

if (( $(echo "$cpu < 50" | bc -l) )); then
  echo -e "\e[32mCPU Usage: $cpu% (Normal)\e[0m"

elif (( $(echo "$cpu < 80" | bc -l) )); then
  echo -e "\e[33mCPU Usage: $cpu% (Medium)\e[0m"

elif (( $(echo "$cpu > 80" | bc -l) )); then
  echo -e "\e[31mWARNING: High CPU Usage!!!!!!!!,go away i'm going to explooooode\e[0m"
fi

 echo "---------------------------------------------"
 
 echo "Memory Usage:"
 free -h
 
 echo "---------------------------------------------"
 echo "Disk Usage"
 df -h

}
if [[ "$1" == "auto" ]]; then
while true; do
  clear
  monitor_system
  sleep 5
done
fi

