if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting


# Initialize Starship prompt
starship init fish | source



alias claude="$HOME/.claude/local/claude"
