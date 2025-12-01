#!/bin/bash
# Wallpaper picker using fuzzel and matugen with preview

WALLPAPER_DIR="$HOME/.config/wallpaper"

# Get list of images into array
mapfile -t images < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

# Exit if no images
[ ${#images[@]} -eq 0 ] && exit 0

# Select initial image with fuzzel

selected=$(printf '%s\n' "${images[@]}" | sed "s|$WALLPAPER_DIR/||" | sed 's/\.[^.]*$//' | fuzzel --dmenu --prompt=" Pick a Wallpaper: ")

# Exit if no selection
[ -z "$selected" ] && exit 0

# Find index of selected image
current_index=0
for i in "${!images[@]}"; do
    img_name=$(basename "${images[$i]}")
    img_name_no_ext="${img_name%.*}"
    if [[ "$img_name_no_ext" == "$selected" ]]; then
        current_index=$i
        break
    fi
done

while true; do
    wallpaper="${images[$current_index]}"
    filename=$(basename "$wallpaper")
    filename_no_ext="${filename%.*}"

    # Show preview
    hyprctl dispatch exec "[float;size 70% 50%;move 15% 20%]" "imv-wayland '$wallpaper'"
    sleep 0.3

    # Ask confirmation at bottom
    confirm=$(printf "  Next\n  Apply\n  Previous\n  Cancel" | fuzzel --dmenu --prompt="$filename_no_ext " --lines=4 --anchor=bottom --y-margin=50)

    # Kill preview
    pkill imv-wayland 2>/dev/null

    case "$confirm" in
        *"Apply"*)
            # Parameter selection menu
            scheme_type=$(printf "scheme-tonal-spot - Balanced tonal variations (default)\nscheme-expressive - Bold, high saturation colors\nscheme-vibrant - Energetic, vibrant palette\nscheme-neutral - Subtle, minimal colors\nscheme-monochrome - Single color variations\nscheme-fidelity - High color fidelity to source\nscheme-content - Content-based color extraction\nscheme-fruit-salad - Colorful, playful palette\nscheme-rainbow - Full spectrum colors" | fuzzel --dmenu --prompt="󰏘 Scheme Type: " --select-index=0)
            [ -z "$scheme_type" ] && continue
            scheme_type=$(echo "$scheme_type" | awk '{print $1}')

            contrast=$(printf "0 (standard)\n0.5 (enhanced)\n1 (maximum)\n-0.5 (reduced)" | fuzzel --dmenu --prompt="󰐣 Contrast: " --select-index=0)
            [ -z "$contrast" ] && continue
            contrast_value=$(echo "$contrast" | awk '{print $1}')

            mode=$(printf "dark\nlight" | fuzzel --dmenu --prompt="󰔎 Mode: " --select-index=0)
            [ -z "$mode" ] && continue

            # Apply with selected parameters
            matugen image "$wallpaper" --type "$scheme_type" --contrast "$contrast_value" --mode "$mode"
            pkill waybar; waybar &
            notify-send "Wallpaper" "Applied: $filename_no_ext\nType: $scheme_type\nContrast: $contrast_value\nMode: $mode"
            exec "$0"
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
