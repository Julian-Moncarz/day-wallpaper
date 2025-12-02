# Day Counter Wallpaper

A macOS script that generates a daily wallpaper displaying the number of days since November 22, 2007.

## Requirements

- macOS
- ImageMagick (`brew install imagemagick`)

## Setup

### 1. Install ImageMagick

```bash
brew install imagemagick
```

### 2. Create Scripts directory and copy the script

```bash
mkdir -p ~/Scripts
cp update_day_wallpaper.sh ~/Scripts/
chmod +x ~/Scripts/update_day_wallpaper.sh
```

### 3. Test the script

```bash
~/Scripts/update_day_wallpaper.sh
```

Your wallpaper should update immediately.

### 4. Install the launchd agent (auto-update daily)

```bash
cp com.julian.daywallpaper.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.julian.daywallpaper.plist
```

The wallpaper will now update:
- Every day at 00:01
- On every login

## Customization

Edit `~/Scripts/update_day_wallpaper.sh`:

| Setting | Line | Example |
|---------|------|---------|
| Birth date | `birth=$(date -j -f "%Y-%m-%d" "2007-11-22" "+%s")` | Change `2007-11-22` |
| Resolution | `-size 2560x1600` | `3840x2160` for 4K |
| Background | `xc:"#0a0a0a"` | `xc:"#1a1a2e"` for dark blue |
| Font | `-font "Helvetica-Bold"` | `"Menlo-Bold"`, `"Monaco"` |
| Font size | `-pointsize 400` | `300` for smaller |
| Text color | `-fill "#ffffff"` | `"#00ff00"` for green |

### List available fonts

```bash
magick -list font
```

## Uninstall

```bash
launchctl unload ~/Library/LaunchAgents/com.julian.daywallpaper.plist
rm ~/Library/LaunchAgents/com.julian.daywallpaper.plist
rm ~/Scripts/update_day_wallpaper.sh
rm ~/Pictures/day_wallpaper.png
```
