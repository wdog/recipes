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
apt install xdg-desktop-portal-hyprland hyprland-qtutils hyprland-qtutils-dev libhyprcursor-dev libhyprlang-dev libaquamarine-dev


```

## build install tools


```bash
cargo install hyprshell
cargo install matugen
# install awww https://codeberg.org/LGFae/awww
git clone https://codeberg.org/LGFae/awww
cargo build --release

```

## hyprtasking plugin

```bash
git clone https://github.com/raybbian/hyprtasking.git
cd hyprtasking/
meson setup build
cd build && meson compile
# install
cp libhyprtasking.so ~/.config/hypr/plugins/
```


## waybar custom mpris

```bash
git clone https://github.com/Andeskjerf/waybar-module-music.git
cd waybar-module-music
cargo build --release

cp target/release/waybar-module-music ~
```



## icons gtk theme

- KORA https://www.gnome-look.org/p/1256209
- QOGIR DARK https://github.com/vinceliuice/Qogir-theme.git

reload_gtk_theme to apply
