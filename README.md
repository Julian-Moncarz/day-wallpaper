# Day Counter Wallpaper

A macOS script that generates a daily wallpaper displaying the number of days since your birth date—a visual reminder that each day counts.

![Example](https://via.placeholder.com/800x500/0a0a0c/ffffff?text=Day+6,234)

## Features

- 🎨 **5 built-in color themes**: silver, gold, blue, green, rose
- ⚙️ **Configurable**: birth date, resolution, font, colors
- 🔄 **Auto-updates** daily at midnight via launchd
- 🖥️ **macOS Sequoia compatible** with aggressive cache invalidation

## Requirements

- macOS
- ImageMagick: `brew install imagemagick`

## Quick Start

```bash
# 1. Install ImageMagick
brew install imagemagick

# 2. Clone and install
git clone https://github.com/yourusername/day-wallpaper.git
cd day-wallpaper

# 3. Copy files to Scripts directory
mkdir -p ~/Scripts
cp update_day_wallpaper.sh config.sh ~/Scripts/
chmod +x ~/Scripts/update_day_wallpaper.sh

# 4. Edit your birth date
nano ~/Scripts/config.sh

# 5. Test it
~/Scripts/update_day_wallpaper.sh

# 6. Enable auto-update (optional)
cp com.julian.daywallpaper.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.julian.daywallpaper.plist
```

## Configuration

Edit `~/Scripts/config.sh`:

```bash
# Your birth date
BIRTH_DATE="2007-11-22"

# Display resolution
RESOLUTION="2560x1600"

# Background color
BG_COLOR="#0a0a0c"

# Color theme: silver, gold, blue, green, rose, or custom
TEXT_THEME="silver"

# Font (run `magick -list font` to see available fonts)
# Recommended: Avenir-Black, Avenir-Heavy, Avenir-Next-Bold
FONT="Avenir-Black"
FONT_SIZE="400"
```

### Color Themes

| Theme | Description |
|-------|-------------|
| `silver` | Clean metallic silver (default) |
| `gold` | Warm gold/bronze |
| `blue` | Cool ocean blue |
| `green` | Matrix-style green |
| `rose` | Soft rose/pink |
| `custom` | Define your own gradient |

### Custom Colors

Set `TEXT_THEME="custom"` and define 6 colors from highlight to deep shadow:

```bash
TEXT_THEME="custom"
CUSTOM_COLORS=("#ff0000" "#cc0000" "#990000" "#660000" "#330000" "#000000")
```

## Troubleshooting

**Wallpaper not updating?**
```bash
# Check logs
cat /tmp/daywallpaper.log
cat /tmp/daywallpaper.error.log

# Manually trigger
~/Scripts/update_day_wallpaper.sh
```

**ImageMagick not found?**
```bash
brew install imagemagick
```

## Uninstall

```bash
launchctl unload ~/Library/LaunchAgents/com.julian.daywallpaper.plist
rm ~/Library/LaunchAgents/com.julian.daywallpaper.plist
rm ~/Scripts/update_day_wallpaper.sh ~/Scripts/config.sh
rm ~/Pictures/day_wallpaper.png
```

## License

MIT
