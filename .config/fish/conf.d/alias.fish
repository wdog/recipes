alias xr 'xrdb -merge ~/.Xresources'
alias venv 'source venv/bin/activate.fish'
alias dir 'dir --color'
alias fd "fdfind"
alias bat "batcat"

# +-----------+
# | ALIAS APT |
# +-----------+

alias u "sudo apt update"
alias ee "apt-cache search '' | cut -d ' ' -f 1 |  fzf -e --multi --cycle  --preview 'apt-cache show {1}' | xargs -r sudo apt install -y"
alias s "sudo apt-file search"
alias S "sudo apt show"
alias U "sudo apt dist-upgrade"
alias i "sudo apt install"
alias R "sudo apt purge"
alias C "sudo apt autoremove --purge"

function e
    command apt list "*$argv*"
end

# +------+
# | VCSH |
# +------+

# vcsh status
function vcs
    set -l repo (vcsh list | fzf --preview "vcsh {} status -s")
    if test -n "$repo"
        command vcsh $repo commit -a
    end
end

# vcsh detail
function vcd
    vcsh list | fzf --preview "vcsh {} show"
end

# BTRFS
alias b_l "sudo btrbk list snapshots"  # list backups
alias b_r "sudo btrbk run"             # exec snap/backup
alias b_c "sudo btrbk list config"     # btrbk show snap/backup config
alias b_lat "sudo btrbk list latest"   # show latest

alias btc 'bluetoothctl connect'
# fixed OS
#alias fixmouse 'sudo modprobe -r psmouse; sudo modprobe psmouse'

# Utils
alias tailf 'sudo journalctl -f | ccze -A'
alias gimages 'cd /var/lib/libvirt/images/'

alias sail="./vendor/bin/sail"

alias dcu "docker-compose up -d"
alias dcd "docker-compose down --remove-orphans"
alias dcf "docker-compose logs -f"
alias dcue "docker-compose --env-file=.env up -d"
alias dcde "docker-compose --env-file=.env down --remove-orphans"

alias dcl "docker container ls"
alias dcp "docker container prune"

alias dil "docker image ls"
alias dip "docker image prune"

alias dnl "docker network ls"
alias dnp "docker network prune"


alias lint "docker-compose exec -u 1000 app ./vendor/bin/duster lint -u pint -v"
alias fix "docker-compose exec -u 1000 app ./vendor/bin/duster fix -u pint -v"

alias dvl "docker volume ls"
alias dvp "docker volume prune"

alias nd "docker-compose exec laravel-php npm run dev -- --host "

alias np "docker-compose exec laravel-php npm run build"

alias ms "docker-compose exec mysql sh "

alias mss "docker-compose exec mysql mysql -ularavel -plaravel laravel"
alias artn "docker-compose exec --user (id -u):(id -g) laravel-php php artisan"
alias art "docker-compose exec --user (id -u):(id -g) app php artisan"
alias tinn "docker-compose exec --user (id -u):(id -g) laravel-php php artisan tin"
alias tin "docker-compose exec --user (id -u):(id -g) app php artisan tin"
alias composer "docker run --rm -it --user (id -u):(id -g) -v .:/opt -w /opt composer:latest"
alias artr "sudo chown $USER: * -R; chmod 777 bootstrap/cache/ -R; chmod 777 storage -R"
alias artc "art optimize:clear -q; art queue:clear; art queue:flush ; art queue:restart; art reverb:restart; art lo:cl"

# gnome settings write
#alias gsw "busctl --user call org.gnome.Shell /io/elhan/ExtensionsSync io.elhan.ExtensionsSync save" # uploads to server
# gnome settings read
#alias gsr "busctl --user call org.gnome.Shell /io/elhan/ExtensionsSync io.elhan.ExtensionsSync read" # downloads to pc

alias kindle-fix "sudo killall gvfs-mtp-volume-monitor"
alias madness 'docker run --rm -it -v $PWD:/docs -p 3000:3000 dannyben/madness server'


alias ll 'exa --octal-permissions --header --icons --group --time-style=long-iso --git --group-directories-first -l'

# Starship prompt testing
alias prompt-tty 'env STARSHIP_CONFIG=~/.config/starship-tty.toml fish'
alias prompt-fancy 'env STARSHIP_CONFIG=~/.config/starship.toml fish'

# Git

alias gst "git status -s"
alias nah "git reset --hard && git clean -df"
alias lg "lazygit"

# Using function instead of alias to avoid automatic git completion wrapping
function dotfiles --description 'Manage dotfiles repository'
    command git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME $argv
end

function dotfiles-ls --description 'List all tracked dotfiles'
    command git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME ls-tree -r HEAD --name-only
end

alias srec "wf-recorder -g (slurp) -f ~/screencasts/(date +%Y%m%d_%H:%M:%S).mp4"

function wip -d "commit git with default wip message"
    git status -s

    set -l message "WIP"
    if test (count $argv) -gt 0
        set message $argv
    end
    git add .
    git commit -a -m "$message"
end

alias sshhome "ssh root@wdog.duckdns.org -p 2222 -i ~/.ssh/id_rsa"

function ask -d "sgpt shell command suggestions"
    $HOME/.local/bin/sgpt --describe-shell -- $argv
end

# vim: ft=fish
