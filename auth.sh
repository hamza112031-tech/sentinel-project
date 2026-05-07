#!/bin/bash
 
signup() {
    echo "--- Sign Up ---"
    echo "Enter username: "
    read username
 
    if grep -q "^$username:" .sentinel_users 2>/dev/null; then
        echo "Username already exists!"
        return
    fi
 
    echo "Enter password: "
    read -s password
 
    # FIX: المتغير اسمه password مش pass
    if [[ ${#password} -lt 6 ]]; then
        echo "Password too short! Minimum 6 characters."
        return 1
    fi
 
    hashed=$(echo -n "$password" | sha256sum | awk '{print $1}')
    echo "$username:$hashed" >> .sentinel_users
    chmod 600 .sentinel_users
    echo "User created successfully!"
}
 
login() {
    echo "--- Login ---"
    echo "Enter username: "
    read username
    echo "Enter password: "
    read -s password
 
    hashed=$(echo -n "$password" | sha256sum | awk '{print $1}')
    store=$(grep "^$username:" .sentinel_users 2>/dev/null | cut -d: -f2)
 
    if [[ "$hashed" == "$store" ]]; then
        echo "Login successful! Welcome, $username."
        return 0
    else
        echo "Invalid username or password."
        return 1
    fi
}
