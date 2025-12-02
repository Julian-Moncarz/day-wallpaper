#!/bin/bash

# Calculate day number since birth
birth=$(date -j -f "%Y-%m-%d" "2007-11-22" "+%s")
today=$(date "+%s")
days=$(( (today - birth) / 86400 + 1 ))
days_formatted=$(printf "%'d" $days)

# Generate wallpaper image with metallic text effect
/opt/homebrew/bin/magick -size 2560x1600 xc:"rgb(10,10,12)" \
  -gravity center \
  -font "Helvetica-Bold" \
  -pointsize 400 \
  -fill "rgb(0,0,0)" -annotate +12+12 "Day $days_formatted" \
  -fill "rgb(40,40,50)" -annotate +8+8 "Day $days_formatted" \
  -fill "rgb(80,80,95)" -annotate +4+4 "Day $days_formatted" \
  -fill "rgb(160,165,175)" -annotate 0 "Day $days_formatted" \
  -fill "rgb(220,225,235)" -annotate -3-3 "Day $days_formatted" \
  -fill "rgb(255,255,255)" -annotate -5-5 "Day $days_formatted" \
  -type TrueColor \
  /Users/julianmoncarz/Pictures/day_wallpaper.png

# Set as wallpaper (cache invalidation trick for macOS Sequoia)
cp /Users/julianmoncarz/Pictures/day_wallpaper.png /Users/julianmoncarz/Pictures/day_wallpaper_tmp.png
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/julianmoncarz/Pictures/day_wallpaper_tmp.png"'
sleep 0.5
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/julianmoncarz/Pictures/day_wallpaper.png"'
rm /Users/julianmoncarz/Pictures/day_wallpaper_tmp.png
