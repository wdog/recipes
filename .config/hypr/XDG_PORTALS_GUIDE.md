# Guida XDG Desktop Portals per Hyprland

## Configurazione Corrente

### Portali Attivi
- **xdg-desktop-portal** - Demone principale (obbligatorio)
- **xdg-desktop-portal-hyprland** - Backend per Hyprland
- **xdg-document-portal** - Per Flatpak/Snap

### Portali Disabilitati
- **xdg-desktop-portal-gtk** - Mascherato (conflitto con Hyprland)
- **xdg-desktop-portal-gnome** - Disabilitato
- **xdg-desktop-portal-wlr** - Disabilitato

## Comandi di Verifica

### Controllare i processi attivi
```bash
ps aux | grep -i "xdg.*portal" | grep -v grep
```

**Output corretto:**
```
/usr/libexec/xdg-desktop-portal
/usr/libexec/xdg-desktop-portal-hyprland
/usr/libexec/xdg-document-portal
```

### Verificare lo stato dei servizi
```bash
systemctl --user list-units | grep -i portal
```

**Output corretto:**
- `xdg-desktop-portal-gtk.service` → **masked**
- `xdg-desktop-portal-hyprland.service` → **active (running)**
- `xdg-desktop-portal.service` → **active (running)**
- `xdg-document-portal.service` → **active (running)**

### Log del portale Hyprland
```bash
journalctl --user -u xdg-desktop-portal-hyprland.service -n 50
```

Dovresti vedere:
- `Found output name DP-5` e `Found output name DP-7` (i tuoi monitor)
- Nessun errore di crash

## Test Funzionalità

### 1. Screenshot
Testa se gli screenshot funzionano:
```bash
# Con grim (se installato)
grim ~/test-screenshot.png

# O usa l'hotkey configurata in Hyprland
```

### 2. Screen Sharing (ScreenCast)
- Apri un'app che usa screen sharing (Discord, Teams, OBS)
- Prova a condividere lo schermo
- Dovrebbe apparire un picker di xdg-desktop-portal-hyprland

### 3. File Picker
- Apri un'app Flatpak (se ne hai)
- Prova a fare "Open File" o "Save File"
- Il file picker dovrebbe aprirsi correttamente

### 4. Shortcuts Globali
Le global shortcuts dovrebbero funzionare con app che le richiedono.

## Troubleshooting

### Se xdg-desktop-portal-gtk riappare
```bash
systemctl --user mask xdg-desktop-portal-gtk.service
systemctl --user daemon-reload
systemctl --user restart xdg-desktop-portal.service
```

### Se gli screenshot non funzionano
```bash
# Verifica che xdg-desktop-portal-hyprland sia attivo
systemctl --user status xdg-desktop-portal-hyprland.service

# Riavvia i portali
systemctl --user restart xdg-desktop-portal.service
```

### Vedere i log in tempo reale
```bash
journalctl --user -u xdg-desktop-portal.service -f
```

### Testare la comunicazione D-Bus
```bash
# Verifica che il portale risponda su D-Bus
busctl --user list | grep portal
```

**Output atteso:**
```
org.freedesktop.portal.Desktop
org.freedesktop.impl.portal.desktop.hyprland
```

## Configurazione File

### File di configurazione portali
`/usr/share/xdg-desktop-portal/portals/hyprland.portal`
```ini
[portal]
DBusName=org.freedesktop.impl.portal.desktop.hyprland
Interfaces=org.freedesktop.impl.portal.Screenshot;org.freedesktop.impl.portal.ScreenCast;org.freedesktop.impl.portal.GlobalShortcuts;
UseIn=Hyprland;
```

### Override (opzionale)
Se hai bisogno di override: `~/.config/xdg-desktop-portal/hyprland-portals.conf`

## Cosa fa ogni Portale

### xdg-desktop-portal (main)
- Demone principale che gestisce le richieste
- Inoltra le chiamate ai backend specifici

### xdg-desktop-portal-hyprland
- **Screenshot**: Cattura schermo/finestre
- **ScreenCast**: Condivisione schermo (video streaming)
- **GlobalShortcuts**: Scorciatoie globali

### xdg-document-portal
- Accesso sicuro ai file per app sandboxed (Flatpak/Snap)

## Riavvio Completo dei Portali

Se qualcosa non funziona:
```bash
systemctl --user restart xdg-desktop-portal.service
systemctl --user restart xdg-document-portal.service
```

I servizi backend (hyprland) si avviano automaticamente quando necessari.

## Mantenimento

### Dopo aggiornamenti di sistema
Verifica che xdg-desktop-portal-gtk sia ancora mascherato:
```bash
systemctl --user status xdg-desktop-portal-gtk.service | grep masked
```

### Se installi GNOME/GTK apps
Non è necessario abilitare il portale GTK. Le app GTK funzionano comunque con il portale Hyprland.

---

## Quick Check (copia/incolla)
```bash
echo "=== Processi attivi ===" && \
ps aux | grep -i "xdg.*portal" | grep -v grep && \
echo -e "\n=== Stato servizi ===" && \
systemctl --user list-units | grep -i portal
```

Output corretto: 3 processi in esecuzione, hyprland service attivo, gtk mascherato.
