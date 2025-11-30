# Configurazione xdg-desktop-portal-hyprland - Stato Avanzamento

## Data: 2025-11-28

## Problema Identificato
xdg-desktop-portal-hyprland non viene avviato correttamente con Hyprland.

## Analisi Effettuata

### Pacchetti Installati ✓
- `xdg-desktop-portal` (1.20.3+ds-1)
- `xdg-desktop-portal-hyprland` (1.3.11-1) ✓
- `xdg-desktop-portal-gtk` (1.15.3-2) ✓
- `xdg-desktop-portal-wlr` (0.7.1-2)
- `xdg-desktop-portal-gnome` (49.0-1)

### Stato Servizi
```
xdg-desktop-portal.service - ATTIVO (running)
xdg-desktop-portal-hyprland.service - DISPONIBILE (static)
xdg-desktop-portal-gtk - ATTIVO (running)
xdg-desktop-portal-wlr - ATTIVO (running)
```

### Variabili d'Ambiente ✓
- `XDG_CURRENT_DESKTOP=Hyprland` ✓ (corretto)
- Già impostato in `~/.config/hypr/conf/autostart.conf:9-10`

### Configurazione Attuale (ERRATA)
**File**: `~/.config/xdg-desktop-portal/portals.conf`
```
[preferred]
default=gtk
org.freedesktop.impl.portal.Screenshot=wlr
org.freedesktop.impl.portal.ScreenCast=wlr
```

**Problema**:
- Nome file errato (dovrebbe essere `hyprland-portals.conf`)
- Backend sbagliato (usa `gtk` e `wlr` invece di `hyprland`)

## Soluzione Raccomandata dalla Community

Secondo la [documentazione ufficiale Hyprland](https://wiki.hypr.land/Hypr-Ecosystem/xdg-desktop-portal-hyprland/):

### 1. Creare il file corretto
**File**: `~/.config/xdg-desktop-portal/hyprland-portals.conf`

**Contenuto**:
```
[preferred]
default = hyprland;gtk
org.freedesktop.impl.portal.FileChooser = gtk
```

**Motivazione**:
- `xdg-desktop-portal-hyprland` non implementa il file picker
- GTK viene usato come fallback per il file chooser
- Hyprland gestisce screenshot e screencast nativamente

### 2. Gestire il vecchio file
- Opzione A: Rinominare `portals.conf` in `portals.conf.backup`
- Opzione B: Eliminare `portals.conf`

### 3. Riavvio
- Il portale viene avviato automaticamente da D-Bus
- **NON serve** aggiungere exec-once nell'autostart
- Basta riavviare Hyprland o fare logout/login

## Prossimi Passi (DA FARE)
- [ ] Backup del file attuale `portals.conf`
- [ ] Creare `hyprland-portals.conf` con configurazione corretta
- [ ] Rimuovere o rinominare `portals.conf`
- [ ] Riavviare Hyprland
- [ ] Verificare funzionamento con `systemctl --user status xdg-desktop-portal-hyprland`
- [ ] Test screenshot/screencast

## Riferimenti
- [Hyprland Wiki - xdg-desktop-portal-hyprland](https://wiki.hypr.land/Hypr-Ecosystem/xdg-desktop-portal-hyprland/)
- [GitHub - xdg-desktop-portal-hyprland](https://github.com/hyprwm/xdg-desktop-portal-hyprland)
- [ArchWiki - XDG Desktop Portal](https://wiki.archlinux.org/title/XDG_Desktop_Portal)

## Note
- Il servizio xdg-desktop-portal-hyprland ha tipo "static", quindi viene avviato da D-Bus on-demand
- Non ci sono errori critici, solo configurazione backend errata
