#!/bin/bash
backup(){
echo "---BACKUP System---"
echo "Enter directory to backup: "
read dir
if [[ ! -d "$dir" ]]; then echo "Directory doesn't exist!!! focus and try agian"
return
fi

timestamp=$(date +"%Y-%m-%d_%H-%M")
mkdir -p backups

filename="backups/backup_$timestamp.tar.gz"
tar -czf "$filename" "$dir"
echo "Backup created: $filename"

size=$(du -h "$filename" | awk '{print $1}')
echo "$timestamp | $dir | $filename | $size">>backup.log
echo "Backup created: $filename"

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

echo "1) Create Backup"
echo "2) View Logs"

read -p "Choose option: " choice
if [[ "$choice" == "1" ]]; then
backup

elif [[ "$choice" == "2" ]]; then
view_logs

else
echo "Invalid choice"
fi
}
