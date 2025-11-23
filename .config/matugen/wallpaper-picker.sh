#!/bin/bash
# Wallpaper picker using fuzzel and matugen with preview

WALLPAPER_DIR="$HOME/.config/wallpaper"

# Get list of images into array
mapfile -t images < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

# Exit if no images
[ ${#images[@]} -eq 0 ] && exit 0

# Select initial image with fuzzel
selected=$(printf '%s\n' "${images[@]}" | sed "s|$WALLPAPER_DIR/||" | fuzzel --dmenu --prompt="  Wallpaper: ")

# Exit if no selection
[ -z "$selected" ] && exit 0

# Find index of selected image
current_index=0
for i in "${!images[@]}"; do
    if [[ "${images[$i]}" == "$WALLPAPER_DIR/$selected" ]]; then
        current_index=$i
        break
    fi
done

while true; do
    wallpaper="${images[$current_index]}"
    filename=$(basename "$wallpaper")

    # Show preview
    hyprctl dispatch exec "[float;size 70% 50%;move 15% 20%]" "imv-wayland '$wallpaper'"
    sleep 0.3

    # Ask confirmation at bottom
    confirm=$(printf "  Next\n  Apply\n  Previous\n  Cancel" | fuzzel --dmenu --prompt="$filename " --lines=4 --anchor=bottom --y-margin=50)

    # Kill preview
    pkill imv-wayland 2>/dev/null

    case "$confirm" in
        *"Apply"*)
            matugen image "$wallpaper"
            pkill waybar; waybar &
            notify-send "Wallpaper" "Applied: $filename"
            exit 0
            ;;
        *"Previous"*)
            current_index=$(( (current_index - 1 + ${#images[@]}) % ${#images[@]} ))
            continue
            ;;
        *"Next"*)
            current_index=$(( (current_index + 1) % ${#images[@]} ))
            continue
            ;;
        *"Cancel"*)
            exit 0
            ;;
        *)
            exit 0
            ;;
    esac
done
