# FISHER
# curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fish_add_path ~/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path /usr/local/bin/Telegram

# - deno for vim
fish_add_path $DENO_INSTALL/bin


# - execute last command with sudo
function sudobangbang --on-event fish_postexec
    abbr -a !! --position command "sudo $argv[1]"
end


function cheat --description="Alternative to tldr"
    curl --silent cheat.sh/"$argv"
end


function disable_trackpad --description="disable trackpoint"
    set -l DEV (grep -i trackpoint /proc/bus/input/devices -B 1 -A 2 | tail -1 | sed 's/^.*=\(.*\)/\/sys\/\1/')
    if test -n "$DEV" -a -e "$DEV/inhibited"
        echo 1 | sudo tee $DEV/inhibited >/dev/null 2>&1
    end
end

# exec on start
if status is-interactive
    disable_trackpad
end

#spc completion fish --fish-description | source
