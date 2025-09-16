#!/bin/bash

# Get network info
INTERFACE=$(ip route | grep default | head -1 | awk '{print $5}')
IP=$(ip addr show "$INTERFACE" 2>/dev/null | grep 'inet ' | head -1 | awk '{print $2}' | cut -d/ -f1)

if [ -n "$IP" ]; then
    # Extract last 2 octets (e.g., 192.168.1.100 -> 1.100)
    LAST_TWO_OCTETS=$(echo "$IP" | awk -F. '{print $(NF-1)"."$NF}')

    # Check if wifi or ethernet
    if [[ "$INTERFACE" == wl* ]] || [[ "$INTERFACE" == wlan* ]]; then
        # WiFi - get SSID
        SSID=$(iwgetid -r 2>/dev/null || echo "WiFi")
        echo "📡 $SSID ($LAST_TWO_OCTETS)"
    else
        # Ethernet
        echo "🔗 $LAST_TWO_OCTETS"
    fi
else
        echo "❌ No Connection"
fi