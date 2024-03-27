#!/bin/bash
sleep 0.2

## Search folder
selected=$( find ~/Bilder/Wallpaper -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
do
    echo -en "$rfile\x00icon\x1f~/Bilder/Wallpaper/${rfile}\n"
done | rofi -dmenu -i -replace -config /home/sascha/.config/hypr/rofi/rofi_wallpaper_selection.rasi)

## ...if not wallpaper selected, exit
if [ ! "$selected" ]; then
    exit
fi

## Get Wallpaper colors with pywall
wal -q -i ~/Bilder/Wallpaper/$selected

echo $selected
echo ~/Bilder/Wallpaper/$selected

## Set Wallpaper
swww img ~/Bilder/Wallpaper/$selected \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"

## Send "done"-notification
notify-send "Wallpaper updated!"
