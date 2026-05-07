#!/bin/bash
 
source auth.sh
source monitor.sh
source backup.sh
source tasks.sh
source uptime.sh
source fileserver.sh
 
echo "=============================="
echo "    ______ SENTINEL ______    "
echo "=============================="
 
# FIX: loop عشان بعد Sign Up يقدر يعمل Login
while true; do
    echo ""
    echo "1. Sign Up"
    echo "2. Login"
    echo "3. Exit"
    read -p "Choose option: " auth_choice
 
    if [[ "$auth_choice" == "1" ]]; then
        signup
 
    elif [[ "$auth_choice" == "2" ]]; then
        login
        if [[ $? -eq 0 ]]; then
            while true; do
                echo ""
                echo "========== MAIN MENU =========="
                echo "1. Monitor System"
                echo "2. Manage Backups"
                echo "3. Admin Tasks"
                echo "4. Remote Uptime Monitor"
                echo "5. File Server"
                echo "6. Logout"
                echo ""
                read -p "Choose option: " choice
 
                case $choice in
                    1) monitor_system ;;
                    2) backup_menu ;;
                    3) tasks_menu ;;
                    4) uptime_menu ;;
                    5) fileserver_menu ;;
                    6) echo "Goodbye!"; break ;;
                    *) echo "Invalid choice!" ;;
                esac
            done
        fi
 
    elif [[ "$auth_choice" == "3" ]]; then
        echo "Goodbye!"
        exit
    else
        echo "Invalid choice!"
    fi
done
