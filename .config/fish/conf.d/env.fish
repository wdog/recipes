# Env variables needed for wayland and sway
set -gx XDG_CURRENT_DESKTOP wayfire
set -gx DENO_INSTALL "/home/$USER/.deno"
set -gx XDG_CONFIG_HOME ~/.config
set -gx TERMINAL alacritty
set -gx EDITOR vim
set -gx VIRSH_DEFAULT_CONNECT_URI qemu:///system
set -gx LIBVIRT_DEFAULT_URI qemu:///system
set -gx MOZ_ENABLE_WAYLAND 1
set -gx TZ 'Europe/Rome'
set -gx QT_QPA_PLATFORM wayland
set -gx SPOTIFY_ID ad19356db1454768ade5ad17279f72c7
set -Ux XDG_SESSION_DESKTOP sway
set -Ux XDG_RUNTIME_DIR /run/user/(id -u)
#set -Ux QT_WAYLAND_DISABLE_WINDOWDECORATION 1
#set -Ux GDK_BACKEND wayland
set -gx _JAVA_AWT_WM_NONREPARENTING 1

set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx MOZ_WEBRENDER 1
set -gx XDG_SESSION_TYPE wayland
set -gx CLUTTER_BACKEND wayland
set -gx SDL_VIDEODRIVER wayland


# - man colors
# fisher install decors/fish-colored-man
set -gx man_blink -o red
set -gx man_bold -o magenta
set -gx man_standout -b white 586e75
set -gx man_underline -u yellow

