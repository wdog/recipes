#!/bin/bash

STORE_PATH=/tmp/waybar-album-art.jpg

#curl -so $STORE_PATH $(playerctl metadata --format '{{ mpris:artUrl }}')
#echo $STORE_PATH


album_art=$(playerctl -p spotify metadata mpris:artUrl)
if [[ -z $album_art ]]
then
   # spotify is dead, we should die too.
   exit
fi
curl -s  "${album_art}" --output $STORE_PATH
echo -e "$STORE_PATH"
