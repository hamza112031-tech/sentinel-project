#!/bin/bash
PID_FILE=".fileserver.pid"
LOG_FILE="fileserver_access.log"

# ألوان
RED='\e[31m'
GREEN='\e[32m'
NC='\e[0m'


start_server() {
    # التحقق إن السيرفر مش شغال بالفعل
    if [[ -f "$PID_FILE" ]]; then
        echo "Server is already running!"
        return
    fi

    echo "Enter directory to share: "
    read dir

    if [[ ! -d "$dir" ]]; then
        echo "Directory doesn't exist!"
        return
    fi

    # الانتقال للفولدر وتشغيل السيرفر في الخلفية
    cd "$dir"
    python3 -m http.server 8000 >> "$OLDPWD/$LOG_FILE" 2>&1 &

    # حفظ الـ PID
    echo $! > "$OLDPWD/$PID_FILE"
    echo -e "${GREEN}Server started on port 8000${NC}"
    echo "Sharing: $dir"
    echo "PID: $!"
}


stop_server() {
    if [[ ! -f "$PID_FILE" ]]; then
        echo "Server is not running!"
        return
    fi

    pid=$(cat "$PID_FILE")
    kill "$pid"
    rm "$PID_FILE"
    echo -e "${RED}Server stopped.${NC}"
}


server_status() {
    if [[ -f "$PID_FILE" ]]; then
        pid=$(cat "$PID_FILE")
        echo -e "Server is ${GREEN}RUNNING${NC} (PID: $pid)"
    else
        echo -e "Server is ${RED}STOPPED${NC}"
    fi
}


view_log() {
    if [[ ! -f "$LOG_FILE" ]] || [[ ! -s "$LOG_FILE" ]]; then
        echo "No access logs yet!"
        return
    fi

    echo "=== Access Log ==="
    cat "$LOG_FILE"
}


fileserver_menu() {
    while true; do
        echo ""
        echo "=== File Server ==="
        echo "1. Start Sharing"
        echo "2. Stop Sharing"
        echo "3. Server Status"
        echo "4. View Access Log"
        echo "5. Back to Main Menu"
        echo ""
        read -p "Choose: " choice

        case $choice in
            1) start_server ;;
            2) stop_server ;;
            3) server_status ;;
            4) view_log ;;
            5) break ;;
            *) echo "Invalid choice!" ;;
        esac
    done
}
