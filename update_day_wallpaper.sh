#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/config.sh"

# Default values
BIRTH_DATE="2007-11-22"
RESOLUTION="2560x1600"
BG_COLOR="#0a0a0c"
TEXT_THEME="silver"
FONT="Helvetica-Bold"
FONT_SIZE="400"
OUTPUT_PATH=""

# Load config if exists
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

# Set output path
OUTPUT="${OUTPUT_PATH:-$HOME/Pictures/day_wallpaper.png}"
OUTPUT_TMP="${OUTPUT%.png}_tmp.png"

# Check for ImageMagick
if ! command -v magick &> /dev/null; then
    if [[ -x /opt/homebrew/bin/magick ]]; then
        MAGICK="/opt/homebrew/bin/magick"
    elif [[ -x /usr/local/bin/magick ]]; then
        MAGICK="/usr/local/bin/magick"
    else
        echo "Error: ImageMagick not found. Install with: brew install imagemagick" >&2
        exit 1
    fi
else
    MAGICK="magick"
fi

# Calculate day number since birth
if ! birth=$(date -j -f "%Y-%m-%d" "$BIRTH_DATE" "+%s" 2>/dev/null); then
    echo "Error: Invalid birth date format. Use YYYY-MM-DD" >&2
    exit 1
fi
today=$(date "+%s")
days=$(( (today - birth) / 86400 + 1 ))
days_formatted=$(printf "%'d" "$days")

# Get colors based on theme (6 colors: highlight -> deep shadow)
get_theme_colors() {
    case "$1" in
        gold)   echo "#fffef0 #f5e6a3 #c9a227 #8b6914 #4a3a0a #000000" ;;
        blue)   echo "#e0f0ff #90c0e8 #4a90c0 #2a5080 #152840 #000000" ;;
        green)  echo "#e0ffe0 #90e890 #40a040 #206020 #103010 #000000" ;;
        rose)   echo "#fff0f0 #e8a0a0 #c05070 #802040 #401020 #000000" ;;
        *)      echo "#ffffff #dce1eb #a0a5af #50505f #282832 #000000" ;;  # silver default
    esac
}

if [[ "$TEXT_THEME" == "custom" ]] && [[ -n "${CUSTOM_COLORS:-}" ]]; then
    colors_str="${CUSTOM_COLORS[*]}"
else
    colors_str=$(get_theme_colors "$TEXT_THEME")
fi

# Parse colors into array
read -ra colors <<< "$colors_str"

# Generate wallpaper with layered metallic text effect
$MAGICK -size "$RESOLUTION" xc:"$BG_COLOR" \
    -gravity center \
    -font "$FONT" \
    -pointsize "$FONT_SIZE" \
    -fill "${colors[5]}" -annotate +10+10 "Day $days_formatted" \
    -fill "${colors[4]}" -annotate +6+6 "Day $days_formatted" \
    -fill "${colors[3]}" -annotate +3+3 "Day $days_formatted" \
    -fill "${colors[2]}" -annotate +0+0 "Day $days_formatted" \
    -fill "${colors[1]}" -annotate -2-2 "Day $days_formatted" \
    -fill "${colors[0]}" -annotate -4-4 "Day $days_formatted" \
    -type TrueColor \
    "$OUTPUT"

# Set as wallpaper (aggressive cache invalidation for macOS Sequoia)
killall WallpaperAgent 2>/dev/null || true
rm -f ~/Library/Application\ Support/com.apple.wallpaper/Store/Index.plist 2>/dev/null || true
killall Dock 2>/dev/null || true
sleep 0.5
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$OUTPUT\""

echo "Wallpaper updated: Day $days_formatted"
