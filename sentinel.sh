#!/bin/bash

source auth.sh
source monitor.sh
source backup.sh
source tasks.sh
source uptime.sh
source fileserver.sh
echo "=============================="
echo "    ______ SENTINEL______    "

echo "1. Sign Up"
echo "2. Login"
echo "3.Exit"
read -p "Choose option:" auth_choice
if [[ "$auth_choice" == "1" ]]; then
signup

elif [[ "$auth_choice" == "2" ]]; then
login
if [[ $? -eq 0 ]]; then

while true
do
echo "========== MAIN MENU =========="
echo "1.Monitor System"
echo "2.Manage Backups"
echo "3.Admin Tasks"
echo "4.Remote Uptime Monitor"
echo "5.File Server"
echo "6.Exit"

read -p "Choose option: " choice
 if [[ "$choice" == "1" ]]; then
monitor_system

elif [[ "$choice" == "2" ]]; then
backup_menu

elif [[ "$choice" == "3" ]]; then
tasks_menu
elif [[ "$choice" == "4" ]]; then
uptime_menu

elif [[ "$choice" == "5" ]]; then
fileserver_menu
elif [[ "$choice" == "6" ]]; then
echo "Goodbye back again with money,hahaha!"
exit
else
echo "Invalid choice!"
 fi
done
fi

elif [[ "$auth_choice" == "3" ]]; then
exit
else
echo "Invalid choice!"
fi
