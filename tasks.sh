#!/bin/bash
TASKS_FILE=".admin_tasks.csv"

# ألوان للطباعة
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'
NC='\e[0m' # إلغاء اللون

# === add_task ===
add_task() {
    echo "Enter task name: "
    read name

    echo "Enter priority (HIGH/MED/LOW): "
    read priority

    echo "Enter due date (YYYY-MM-DD): "
    read due_date

    # عمل ID تلقائي = عدد السطور + 1
    id=$(wc -l < "$TASKS_FILE" 2>/dev/null || echo 0)
    id=$((id + 1))

    echo "$id,$name,$priority,$due_date" >> "$TASKS_FILE"
    echo "Task added successfully!"
}

# === view_tasks ===
view_tasks() {
    if [[ ! -f "$TASKS_FILE" ]]; then
        echo "No tasks found!"
        return
    fi

    echo "=== Admin Tasks ==="
    printf "%-5s %-20s %-10s %-15s\n" "ID" "Task" "Priority" "Due Date"
    echo "----------------------------------------------------"

    # ترتيب: HIGH أولاً ثم MED ثم LOW، وبعدين حسب التاريخ
    (
        grep ",HIGH," "$TASKS_FILE"
        grep ",MED,"  "$TASKS_FILE"
        grep ",LOW,"  "$TASKS_FILE"
    ) | while IFS=',' read -r id name priority due_date; do
        case $priority in
            HIGH) color=$RED ;;
            MED)  color=$YELLOW ;;
            LOW)  color=$GREEN ;;
        esac
        printf "${color}%-5s %-20s %-10s %-15s${NC}\n" "$id" "$name" "$priority" "$due_date"
    done
}

# === update_task ===
update_task() {
    view_tasks
    echo "Enter task ID to update: "
    read id

    if ! grep -q "^$id," "$TASKS_FILE"; then
        echo "Task not found!"
        return
    fi

    echo "Enter new task name: "
    read name
    echo "Enter new priority (HIGH/MED/LOW): "
    read priority
    echo "Enter new due date (YYYY-MM-DD): "
    read due_date

    # استبدال السطر القديم بالجديد
    sed -i "s/^$id,.*/$id,$name,$priority,$due_date/" "$TASKS_FILE"
    echo "Task updated successfully!"
}

# === delete_task ===
delete_task() {
    view_tasks
    echo "Enter task ID to delete: "
    read id

    if ! grep -q "^$id," "$TASKS_FILE"; then
        echo "Task not found!"
        return
    fi

    sed -i "/^$id,/d" "$TASKS_FILE"
    echo "Task deleted successfully!"
}

# === main_menu ===
tasks_menu() {
    while true; do
        echo ""
        echo "=== Task Manager ==="
        echo "1. Add Task"
        echo "2. View Tasks"
        echo "3. Update Task"
        echo "4. Delete Task"
        echo "5. Back"
        read -p "Choose: " choice

        case $choice in
            1) add_task ;;
            2) view_tasks ;;
            3) update_task ;;
            4) delete_task ;;
            5) break ;;
            *) echo "Invalid choice!" ;;
        esac
    done
}
