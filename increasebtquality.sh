#!/bin/bash
# increase_bt_quality.sh
# This script increases Bluetooth audio quality by tweaking ADB settings.
# It is designed to run from Termux (or any terminal with ADB installed).
#
# Requirements:
#   - adb must be installed (e.g., via "pkg install android-tools")
#   - Your device must be connected (via USB or wireless ADB)
#
# Usage:
#   chmod +x increase_bt_quality.sh
#   ./increase_bt_quality.sh

# Check if adb is available
if ! command -v adb >/dev/null 2>&1; then
    echo "Error: adb command not found. Please install the android-tools package."
    exit 1
fi

echo "Starting Bluetooth audio quality enhancement..."
echo "-----------------------------------------------"

# Array of ADB commands to set high-quality Bluetooth settings.
# Note: Some commands (e.g., setting codec priorities) might override each other,
# so your device will choose the best codec among those listed if supported.
commands=(
    "adb shell settings put global bluetooth_a2dp_codec_priority aptX"
    "adb shell settings put global bluetooth_a2dp_codec_priority aptX-HD"
    "adb shell settings put global bluetooth_a2dp_codec_priority AAC"
    "adb shell settings put global bluetooth_a2dp_codec_priority LDAC"
    "adb shell settings put global bluetooth_ldac_quality_index 3"
    "adb shell settings put global bluetooth_disable_absolute_volume 1"
    "adb shell settings put global bluetooth_avrcp_version 6"
    "adb shell settings put global bluetooth_a2dp_supports_optional_codecs 1"
    "adb shell settings put global bluetooth_a2dp_optional_codecs_enabled 1"
)

# Function to execute a command and check for errors.
run_command() {
    local cmd="$1"
    echo "Executing: $cmd"
    eval "$cmd"
    if [ $? -ne 0 ]; then
        echo "❌ Error executing: $cmd" >&2
    else
        echo "✅ Command succeeded: $cmd"
    fi
    echo ""
}

# Execute each command in the list.
for cmd in "${commands[@]}"; do
    run_command "$cmd"
done

echo "-----------------------------------------------"
# Prompt the user to reboot for changes to take effect.
read -p "Would you like to reboot now to apply the changes? (y/n): " answer
if [[ "$answer" =~ ^[Yy] ]]; then
    echo "Rebooting device..."
    adb reboot
else
    echo "Reboot skipped. Please reboot your device manually for changes to take effect."
fi
