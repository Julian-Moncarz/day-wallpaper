#!/bin/bash

# Calculate day number since birth
birth=$(date -j -f "%Y-%m-%d" "2007-11-22" "+%s")
today=$(date "+%s")
days=$(( (today - birth) / 86400 + 1 ))

# Generate wallpaper image
/opt/homebrew/bin/magick -size 2560x1600 xc:"#0a0a0a" \
  -gravity center \
  -font "Helvetica-Bold" \
  -pointsize 400 \
  -fill "#ffffff" \
  -annotate 0 "Day $days" \
  /Users/julianmoncarz/Pictures/day_wallpaper.png

# Set as wallpaper on all desktops
osascript -e 'tell application "System Events" to tell every desktop to set picture to "/Users/julianmoncarz/Pictures/day_wallpaper.png"'
