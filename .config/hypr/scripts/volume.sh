#!/bin/bash


VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)
ID_FILE=/tmp/vol_notif_id
PREV=$(cat "$ID_FILE" 2>/dev/null)
NEW=$(notify-send -p ${PREV:+--replace-id=$PREV} -u low -h int:value:"$VOL" -t 500 "Volume: $VOL %")
echo "$NEW" > "$ID_FILE"
