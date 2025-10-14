# find bindings
# use 'bind'
# bind | grep -e fzf-history-widget -e fzf-file-widget

# search in hidden and exclude .git directories
set fzf_fd_opts --hidden -E .git -E .cargo -E .fonts -E .cache
# open file in editor with CTRL+o
set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

set fzf_diff_highlighter delta

set -x FZF_DEFAULT_COMMAND 'fdfind --type f'
#set fzf_history_time_format %y-%m-%d


bind \cr _fzf_search_history
bind -M insert \cr _fzf_search_history

bind \cf _fzf_search_directory
bind -M insert \cf _fzf_search_directory

bind \cs _fzf_search_git_status
bind -M insert \cs _fzf_search_git_status

bind \cl _fzf_search_git_log
bind -M insert \cl _fzf_search_git_log



