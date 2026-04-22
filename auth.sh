/#!/bin/bash
signup(){
echo "---sign up---"
echo "Enter username: "
read username
echo "Enter password: "
read -s pass
echo hashed=$(echo -n "$pass" | sha256sum | awk '{print $1}')
echo "$username:$hashed" >> .sentinel_users
chmod 600 .sentinel_users
echo "user created successfully"
}

login(){
echo "---login---"
echo "Enter username: "
read username
echo "Enter password: "
read -s pass

echo hashed=$(echo -n "$password" | sha256sum | awk '{print $1}')

store=$(grep "^$username: " .sentinel_users | cut -d: -f2)

if [[ "$hashed" == "$store" ]]; then
echo "Login successful"
else
echo "Invalid username or password"
fi
}

if [[ "$1" == "test" ]]; then  
signup  
login 
fi 

