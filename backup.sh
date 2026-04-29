#!/bin/bash
backup(){
echo "---BACKUP System---"
echo "Enter directory to backup: "
read dir
if [[ ! -d "$dir" ]]; then echo "Directory doesn't exist!!! focus and try agian"
return
fi

timestamp=$(date +"%Y-%m-%d_%H-%M")
filename="backup_$timestamp.tar.gz"
tar -czf "$filename" "$dir"
echo "Backup created: $filename"

size=$(du -h "$filename" | awk '{print $1}')
echo "$timestamp | $dir | $filename | $size">>backup.log
echo "Backup created: $filename"

}
if [[ "$1" == "test" ]]; then
 backup
fi
