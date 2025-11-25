# DOTFILES REQUIREMENTS

current test distro: debian 13 testing


## Packages


```bash
apt install mako wl-paste fuzzel waybar hyprland grim slurp
```

## HYPRLAND

### dependecies


```bash
apt install liblz4-dev libadwaita-1-dev libgtk-4-dev libhyprgraphics-dev libhyprutils-dev hyprland-dev
apt install xdg-desktop-portal-hyprland hyprland-qtutils hyprland-qtutils-dev libhyprcursor-dev


```

## build install tools


```bash
cargo install hyprshell
cargo install matugen
# install awww https://codeberg.org/LGFae/awww
git clone https://codeberg.org/LGFae/awww
cargo build --release

```

