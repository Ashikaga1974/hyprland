#!/bin/bash

# Kill and restart waybar whenever its config files change

config_files="$HOME/.config/hypr/waybar_config/config $HOME/.config/hypr/waybar_config/style.css"
trap "killall waybar" EXIT
while true; do
    logger -i "$0: Starting waybar in the background..."
    waybar -c ~/.config/hypr/waybar_config/config -s ~/.config/hypr/waybar_config/style.css &
    logger -i "$0: Started waybar PID=$!. Waiting for modifications to ${config_files}..."
    inotifywait -e modify ${config_files} 2>&1 | logger -i
    logger -i "$0: inotifywait returned $?. Killing all waybar processes..."
    killall waybar 2>&1 | logger -i
    logger -i "$0: killall waybar returned $?, wait a sec..."
    sleep 1
done