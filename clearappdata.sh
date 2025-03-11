q#!/bin/bash
set -euo pipefail

# Function: list_third_party_apps
# Description: Uses ADB to retrieve a list of third-party app package names.
list_third_party_apps() {
    adb shell pm list packages -3 | sed 's/package://g' | tr -d '\r'
}

# Function: clear_app_data
# Description: Uses ADB to clear cache and app data for a given package.
# Parameters:
#   $1 - The package name.
clear_app_data() {
    local package="$1"
    
    if [[ "$package" == "com.termux" ]]; then
            return 0  # is excluded
    fi
    
    echo "Clearing data for ${package}..."
    adb shell pm clear "${package}"
}

# Function: check_adb_connection
# Description: Verifies that ADB is installed and a device is connected.
check_adb_connection() {
    if ! command -v adb >/dev/null 2>&1; then
        echo "Error: adb command not found. Please install it via 'pkg install android-tools' in Termux."
        exit 1
    fi

    # Check if a device is connected.
    if ! adb get-state 1>/dev/null 2>&1; then
        echo "Error: No device detected. Please connect your Android device with USB debugging enabled."
        exit 1
    fi
}

# Function: main
# Description: Main entry point of the script.
main() {
    check_adb_connection

    echo "Starting to clear data for all third-party apps..."
    local apps
    apps=$(list_third_party_apps)
    echo $(apps)
    sleep 2
    
    if [ -z "$apps" ]; then
        echo "No third-party apps found or unable to retrieve the list."
        exit 0
    fi

    for app in $apps; do
        clear_app_data "${app}"
    done

    echo "All third-party app data has been cleared."
}

# Execute the main function.
main
