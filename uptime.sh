#!/bin/bash
 
WATCHLIST=".watchlist.conf"
LOG_FILE="uptime.log"
 
add_server() {
    echo "Enter server address or IP: "
    read server
    echo "$server" >> "$WATCHLIST"
    echo "Server added!"
}
 
check_servers() {
    if [[ ! -f "$WATCHLIST" ]]; then
        echo "No servers in watchlist!"
        return
    fi
 
    echo "=== Checking Servers ==="
    while read -r server; do
        ping -c 1 -W 1 "$server" &>/dev/null
        if [[ $? -eq 0 ]]; then
            echo "$server ... UP"
        else
            echo "$server ... DOWN"
            echo "$(date '+%Y-%m-%d %H:%M:%S') | $server | DOWN" >> "$LOG_FILE"
        fi
    done < "$WATCHLIST"
}
 
view_log() {
    if [[ ! -f "$LOG_FILE" ]]; then
        echo "No failures logged yet!"
        return
    fi
    echo "=== Failure Log ==="
    cat "$LOG_FILE"
}
 
uptime_menu() {
    while true; do
        echo ""
        echo "=== Remote Uptime Monitor ==="
        echo "1. Add Server"
        echo "2. Check All Servers"
        echo "3. View Failure Log"
        echo "4. Back"
        read -p "Choose: " choice
 
        case $choice in
            1) add_server ;;
            2) check_servers ;;
            3) view_log ;;
            4) break ;;
            *) echo "Invalid choice!" ;;
        esac
    done
}
