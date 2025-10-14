# ~/.config/fish/functions/reload_gtk_themes.fish
function reload_gtk_themes
    # Legge il tema da settings.ini e lo applica
    set -l theme_name (grep "gtk-theme-name" ~/.config/gtk-3.0/settings.ini | cut -d= -f2)
    set -l icon_theme (grep "gtk-icon-theme-name" ~/.config/gtk-3.0/settings.ini | cut -d= -f2)

    gsettings set org.gnome.desktop.interface gtk-theme $theme_name
    gsettings set org.gnome.desktop.interface icon-theme $icon_theme

    # Riavvia nautilus per applicare i cambiamenti
    set -Ux GTK_THEME $theme_name
    killall nautilus 2>/dev/null
    nautilus >/dev/null 2>&1 &
    disown
end
