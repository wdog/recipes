#!/bin/bash

COLORS=~/.config/hypr/colors/colors.conf

while IFS= read -r line; do
    [[ "$line" =~ ^\$([a-z_]+)\ =\ rgba\(([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}) ]] || continue
    name="${BASH_REMATCH[1]}"
    r=$((16#${BASH_REMATCH[2]}))
    g=$((16#${BASH_REMATCH[3]}))
    b=$((16#${BASH_REMATCH[4]}))
    hex="#${BASH_REMATCH[2]}${BASH_REMATCH[3]}${BASH_REMATCH[4]}"
    printf "\e[48;2;%d;%d;%dm     \e[0m  %-40s %s\n" "$r" "$g" "$b" "$name" "$hex"
done < "$COLORS"
