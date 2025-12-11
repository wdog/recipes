#!/bin/bash
# Setup workspace distribution across monitors
# Workspaces 1-5 on Samsung (DP-6), 6-10 on Dell (DP-9)

# Wait for Hyprland to be fully initialized
sleep 2

# Move workspaces 1-5 to Samsung (DP-6)
for i in {1..5}; do
    hyprctl dispatch moveworkspacetomonitor $i DP-6 2>/dev/null || true
done

# Move workspaces 6-10 to Dell (DP-9)
for i in {6..10}; do
    hyprctl dispatch moveworkspacetomonitor $i DP-9 2>/dev/null || true
done

# Return to workspace 1
hyprctl dispatch workspace 1
