#!/bin/bash
 
backup() {
    echo "--- Backup System ---"
    echo "Enter directory to backup: "
    read dir
 
    if [[ ! -d "$dir" ]]; then
        echo "Directory doesn't exist! Please try again."
        return
    fi
 
    timestamp=$(date +"%Y-%m-%d_%H-%M")
    mkdir -p backups
    filename="backups/backup_$timestamp.tar.gz"
 
    tar -czf "$filename" "$dir"
 
    size=$(du -h "$filename" | awk '{print $1}')
    echo "$timestamp | $dir | $filename | $size" >> backup.log
 
    # FIX: مكانش echo مكررة
    echo "Backup created successfully: $filename (Size: $size)"
}
 
view_logs() {
    echo "--- Backup Logs ---"
    if [[ -f backup.log ]]; then
        cat backup.log
    else
        echo "No logs found!"
    fi
}
 
backup_menu() {
    while true; do
        echo ""
        echo "=== Backup Manager ==="
        echo "1. Create Backup"
        echo "2. View Logs"
        echo "3. Back"
        read -p "Choose option: " choice
 
        case $choice in
            1) backup ;;
            2) view_logs ;;
            3) break ;;
            *) echo "Invalid choice!" ;;
        esac
    done
}
