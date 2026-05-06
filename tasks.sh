#!/bin/bash
 
TASKS_FILE=".admin_tasks.csv"
 
add_task() {
    echo "Enter task name: "
    read name
    echo "Enter priority (HIGH/MED/LOW): "
    read priority
    echo "Enter due date (YYYY-MM-DD): "
    read due_date
 
    id=$(wc -l < "$TASKS_FILE" 2>/dev/null || echo 0)
    id=$((id + 1))
 
    echo "$id,$name,$priority,$due_date" >> "$TASKS_FILE"
    echo "Task added!"
}
 
view_tasks() {
    if [[ ! -f "$TASKS_FILE" ]]; then
        echo "No tasks found!"
        return
    fi
    echo "=== Tasks ==="
    cat "$TASKS_FILE"
}
 
delete_task() {
    view_tasks
    echo "Enter task ID to delete: "
    read id
    sed -i "/^$id,/d" "$TASKS_FILE"
    echo "Task deleted!"
}
 
tasks_menu() {
    while true; do
        echo ""
        echo "=== Task Manager ==="
        echo "1. Add Task"
        echo "2. View Tasks"
        echo "3. Delete Task"
        echo "4. Back"
        read -p "Choose: " choice
 
        case $choice in
            1) add_task ;;
            2) view_tasks ;;
            3) delete_task ;;
            4) break ;;
            *) echo "Invalid choice!" ;;
        esac
    done
}
 
