#!/bin/bash

# Function to execute adb shell commands and check success
execute_adb_command() {
    cmd="$1"
    description="$2"

    $cmd
    if [ $? -eq 0 ]; then
        echo "✅ Success: $description"
    else
        echo "❌ Failed: $description"
    fi
}

# Run ADB commands with descriptions
execute_adb_command "adb shell settings put global youtube_max_audio_bitrate 9999" "Set YouTube max audio bitrate to 9999"
execute_adb_command "adb shell settings put global youtube_max_audio_sample_rate 96000" "Set YouTube max audio sample rate to 96000 Hz"
execute_adb_command "adb shell settings put global youtube_max_audio_channels 2" "Set YouTube max audio channels to 2"
execute_adb_command "adb shell settings put global youtube_audio_quality_override 320kbps" "Override YouTube audio quality to 320kbps"
execute_adb_command "adb shell settings put global youtube_disable_throttling 1" "Disable YouTube throttling"
execute_adb_command "adb shell settings put global youtube_premium_audio_quality 1" "Enable YouTube premium audio quality"
execute_adb_command "adb shell settings put global bluetooth_ldac_quality_index 3" "Set Bluetooth LDAC quality index to 3"
execute_adb_command "adb shell settings put global bluetooth_absolute_volume 1" "Enable Bluetooth absolute volume"
execute_adb_command "adb shell service call bluetooth_manager 6" "Restart Bluetooth manager"
execute_adb_command "adb shell settings put global youtube_enable_vp9 1" "Enable YouTube VP9 codec"
execute_adb_command "adb shell settings put global youtube_audio_codec_opus 1" "Enable YouTube Opus audio codec"
execute_adb_command "adb shell settings put global youtube_av1_preferred 0" "Disable AV1 preference in YouTube"

echo "✔️ All commands execut
ed!"
