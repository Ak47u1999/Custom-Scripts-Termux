#!/data/data/com.termux/files/usr/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <WirelessIP:PORT>"
    exit 1
fi

WIRELESS_IP=$1

# Function to check if the last command succeeded
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed."
        exit 1
    fi
}

echo "Everything disconnected!"
until adb disconnect; do
    sleep 1
done

echo "Connecting to $WIRELESS_IP..."
until adb connect "$WIRELESS_IP"; do
    check_success "ADB Connect Wireless"
done

echo "Switching ADB to TCP mode on port 5555..."
until adb tcpip 5555; do
    sleep 1 
    check_success "ADB TCP/IP Mode"
done

sleep 4

echo "Reconnecting to localhost:5555..."
until adb connect localhost:5555; do
    echo "Retrying..."
done

echo "Connecting to $WIRELESS_IP..."
until adb disconnect "$WIRELESS_IP"; do
    check_success "ADB Connect Wireless"
done
sleep 3
# Verify connection
adb devices -l
echo "Currently connected!"
echo "ADB over Wi-Fi setup complete."
