#!/bin/bash
 
PID_FILE=".fileserver.pid"
LOG_FILE="fileserver_access.log"
 
start_server() {
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
 
    cd "$dir"
    python3 -m http.server 8000 >> "$OLDPWD/$LOG_FILE" 2>&1 &
    echo $! > "$OLDPWD/$PID_FILE"
    cd "$OLDPWD"
 
    echo "Server started on port 8000"
    echo "PID: $(cat $PID_FILE)"
}
 
stop_server() {
    if [[ ! -f "$PID_FILE" ]]; then
        echo "Server is not running!"
        return
    fi
 
    kill $(cat "$PID_FILE")
    rm "$PID_FILE"
    echo "Server stopped."
}
 
fileserver_menu() {
    while true; do
        echo ""
        echo "=== File Server ==="
        echo "1. Start Sharing"
        echo "2. Stop Sharing"
        echo "3. Back"
        read -p "Choose: " choice
 
        case $choice in
            1) start_server ;;
            2) stop_server ;;
            3) break ;;
            *) echo "Invalid choice!" ;;
        esac
    done
}
