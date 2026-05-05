#!/bin/bash
WATCHLIST=".watchlist.conf"
LOG_FILE="uptime.log"

# ألوان
RED='\e[31m'
GREEN='\e[32m'
NC='\e[0m'


add_server() {
    echo "Enter server address or IP: "
    read server
    echo "$server" >> "$WATCHLIST"
    echo "Server added successfully!"
}


check_servers() {
    if [[ ! -f "$WATCHLIST" ]]; then
        echo "No servers in watchlist!"
        return
    fi

    echo "=== Checking Servers ==="

    while read -r server; do
        # ping مرة واحدة بـ timeout ثانية واحدة
        result=$(ping -c 1 -W 1 "$server" 2>/dev/null)

        if [[ $? -eq 0 ]]; then
            # استخراج الـ response time من نتيجة الـ ping
            time=$(echo "$result" | grep "time=" | awk -F'time=' '{print $2}' | awk '{print $1}')
            echo -e "$server ... ${GREEN}UP${NC} (${time}ms)"
        else
            echo -e "$server ... ${RED}DOWN${NC}"
            # تسجيل الفشل في اللوج
            echo "$(date '+%Y-%m-%d %H:%M:%S') | $server | DOWN" >> "$LOG_FILE"
        fi

    done < "$WATCHLIST"
}

view_log() {
    if [[ ! -f "$LOG_FILE" ]] || [[ ! -s "$LOG_FILE" ]]; then
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
        echo "1. Add Server to Watchlist"
        echo "2. Check All Servers"
        echo "3. View Failure Log"
        echo "4. Back to Main Menu"
        echo ""
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
