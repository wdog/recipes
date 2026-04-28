#!/usr/bin/env bash
LAYOUT=$(hyprctl getoption general:layout -j | jq -r '.str')

case "$LAYOUT" in
  dwindle)
    BINDS="ALT + J — Inverti split (vert ↔ oriz)
ALT + P — Pseudo-tile
ALT+SUPER + 1 — Reset Dwindle
ALT+SUPER + 2 — Passa a Master
ALT+SUPER + 3 — Passa a Scrolling"
    TITLE="Layout: Dwindle"
    ;;
  master)
    BINDS="ALT+SUPER + K — Ruota: slave successivo → master
ALT+SUPER + J — Ruota: slave precedente → master
ALT+SUPER + H — Orientamento verticale (master a sinistra)
ALT+SUPER + L — Orientamento orizzontale (master in alto)
ALT+SUPER + M — Swap finestra attiva con master
ALT+SUPER + 1 — Passa a Dwindle
ALT+SUPER + 2 — Reset Master
ALT+SUPER + 3 — Passa a Scrolling"
    TITLE="Layout: Master"
    ;;
  scrolling)
    BINDS="ALT + ← → — Sposta focus tra colonne
ALT+SUPER + 1 — Passa a Dwindle
ALT+SUPER + 2 — Passa a Master
ALT+SUPER + 3 — Reset Scrolling"
    TITLE="Layout: Scrolling"
    ;;
  *)
    BINDS="Layout sconosciuto: $LAYOUT"
    TITLE="Layout: ?"
    ;;
esac

printf "%s\n" "$BINDS" | fuzzel --dmenu --prompt="$TITLE  " --no-run-if-empty
