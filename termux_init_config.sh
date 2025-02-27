#!/data/data/com.termux/files/usr/bin/bash

# Function to check if the last command succeeded
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed."
        exit 1
    fi
}

echo "Choose pkg mirror"
until termux-change-repo; do
	check_success "Changing mirror"
done

echo "packages update and upgrade"
until pkg update && pkg upgrade -y; do
    check_success "In Progress....."
done

sleep 2

echo "Installing android-tools"
until pkg install android-tools -y; do
    check_success "ADB Connect Wireless"
done

sleep 2

echo "Upgrade and basic setup complete."
