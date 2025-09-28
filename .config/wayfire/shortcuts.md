# Wayfire Window Manager - Shortcuts Reference

Questa guida contiene tutti gli shortcuts configurati nel file `wayfire.ini` per una facile consultazione.

## Shortcuts Principali

### Applicazioni e Comandi
| Shortcut | Azione | Comando |
|----------|--------|---------|
| `Alt + D` | Launcher applicazioni | fuzzel --show drun |
| `Alt + Enter` | Terminale | alacritty |
| `Ctrl + Alt + L` | Blocco schermo | swaylock |
| `Super + Esc` | Menu logout | nwg-bar |
| `Alt + C` | Clipboard manager | cliphist list \| fuzzel --dmenu |
| `Alt + N` | Network manager | networkmanager_dmenu |

### Screenshot
| Shortcut | Azione | Comando |
|----------|--------|---------|
| `SysRq/Print` | Screenshot area | grim + slurp + swappy |
| `Shift + Print` | Screenshot interattivo | slurp + grim |

### Audio e Luminosità
| Shortcut | Azione |
|----------|--------|
| `Volume Up` | Aumenta volume |
| `Volume Down` | Diminuisce volume |
| `Mute` | Mute/unmute audio |
| `Mic Mute` | Mute/unmute microfono |
| `Brightness Up` | Aumenta luminosità |
| `Brightness Down` | Diminuisce luminosità |

## Gestione Finestre

### Finestre Base
| Shortcut | Azione |
|----------|--------|
| `Alt + Shift + Q` | Chiudi finestra attiva |
| `Alt + F` | Massimizza/ripristina finestra |
| `Alt + T` | Toggle tiling mode |

### Spostamento e Ridimensionamento
| Shortcut | Azione |
|----------|--------|
| `Alt + Pulsante Sinistro` | Sposta finestra |
| `Super + Pulsante Destro` | Ridimensiona finestra |
| `Super + Pulsante Sinistro` | Sposta finestra (simple-tile) |

### Focus Finestre
| Shortcut | Azione |
|----------|--------|
| `Alt + Tab` | Prossima finestra |
| `Alt + Shift + Tab` | Finestra precedente |
| `Alt + Esc` | Fast switcher |
| `Alt + Shift + Esc` | Fast switcher (indietro) |

### Focus Direzionale (Simple Tile)
| Shortcut | Azione |
|----------|--------|
| `Alt + ↑` | Focus finestra sopra |
| `Alt + ↓` | Focus finestra sotto |
| `Alt + ←` | Focus finestra sinistra |
| `Alt + →` | Focus finestra destra |

## Workspace e Desktop

### Cambio Workspace
| Shortcut | Azione |
|----------|--------|
| `Alt + 1-9` | Vai al workspace 1-9 |
| `Alt + Ctrl + ←` | Workspace a sinistra |
| `Alt + Ctrl + →` | Workspace a destra |
| `Alt + Ctrl + ↑` | Workspace sopra |
| `Alt + Ctrl + ↓` | Workspace sotto |

### Sposta Finestre tra Workspace
| Shortcut | Azione |
|----------|--------|
| `Shift + Alt + 1-9` | Sposta finestra e vai al workspace 1-9 |
| `Alt + Ctrl + Shift + ←` | Sposta finestra a workspace sinistra |
| `Alt + Ctrl + Shift + →` | Sposta finestra a workspace destra |
| `Alt + Ctrl + Shift + ↑` | Sposta finestra a workspace sopra |
| `Alt + Ctrl + Shift + ↓` | Sposta finestra a workspace sotto |

### Solo Sposta Finestre
| Shortcut | Azione |
|----------|--------|
| `Shift + Ctrl + Alt + 1-8` | Sposta solo finestra al workspace |

## Grid e Posizionamento

### Grid Layout
| Shortcut | Posizione |
|----------|-----------|
| `Super + KP5` | Centro |
| `Super + KP7` | Top-Left |
| `Super + KP8` | Top |
| `Super + KP9` | Top-Right |
| `Super + KP4` | Sinistra |
| `Super + KP6` | Destra |
| `Super + KP1` | Bottom-Left |
| `Super + KP2` | Bottom |
| `Super + KP3` | Bottom-Right |
| `Super + Down/KP0` | Ripristina |

## Panoramica e Expo

### Scale e Expo
| Shortcut | Azione |
|----------|--------|
| `Super + P` | Scale (panoramica workspace corrente) |
| `Alt + W` | Scale (tutte le finestre) |
| `Alt + E` | Expo (panoramica workspace) |

### Selezione Workspace in Expo
| Shortcut | Workspace |
|----------|-----------|
| `1-9` | Seleziona workspace 1-9 (durante expo) |

## Output e Monitor

### Cambio Monitor
| Shortcut | Azione |
|----------|--------|
| `Super + O` | Prossimo output/monitor |
| `Shift + Super + O` | Prossimo output con finestra |

## Effetti e Funzioni Speciali

### Alpha e Trasparenza
| Shortcut | Azione |
|----------|--------|
| `Alt + Super + Mouse` | Modifica trasparenza |

### Altri Effetti
| Shortcut | Azione |
|----------|--------|
| `Super + I` | Inverti colori |
| `Super + Mouse Wheel` | Zoom |

### 3D e Cube
| Shortcut | Azione |
|----------|--------|
| `Alt + Ctrl + Pulsante Sinistro` | Attiva cubo 3D |

## Gesture Touchpad

### Gesture Multi-touch
| Gesture | Azione |
|---------|--------|
| 4 dita swipe orizzontale | Cambio workspace |
| 4 dita swipe verticale | Cambio workspace |
| 3 dita (gesture personalizzate) | Varie azioni |

---

## Note

- `KP` si riferisce al tastierino numerico
- `Super` è il tasto Windows/Meta
- `Alt` è il tasto Alt
- `Ctrl` è il tasto Control
- `Shift` è il tasto Maiusc

### Configurazione Layout
- **Layout tastiera**: Italiano (`it`)
- **Workspace**: 4x2 (4 orizzontali, 2 verticali)
- **Theme**: Colori scuri con bordi blu per finestre attive

### Applicazioni Autostart
- Waybar (barra superiore)
- Mako (notifiche)
- Blueman (Bluetooth)
- Network Manager
- Kanshi (gestione output)
- SwayOSD (overlay volume/luminosità)

Questo file di configurazione è ottimizzato per un workflow efficiente con tiling window management e shortcuts intuitivi.