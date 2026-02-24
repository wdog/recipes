if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting


# Initialize Starship prompt with TTY detection
if string match -q "/dev/tty*" (tty)
    # Plain config for TTY console (no fancy icons)
    set -x STARSHIP_CONFIG ~/.config/starship-tty.toml
else
    # Fancy config for graphical terminals (Alacritty, etc.)
    set -x STARSHIP_CONFIG ~/.config/starship.toml
end
starship init fish | source



alias claude="~/.local/bin/claude"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
