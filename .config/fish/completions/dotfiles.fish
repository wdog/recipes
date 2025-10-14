# Completions for dotfiles alias
# Provides simple completions without using __fish_git_files to avoid scanning entire home directory

# Disable all default git completions for dotfiles
complete -c dotfiles -e

function __fish_dotfiles_needs_command
    set -l cmd (commandline -opc)
    test (count $cmd) -eq 1
end

function __fish_dotfiles_using_command
    set -l cmd (commandline -opc)
    test (count $cmd) -gt 1; and contains -- $argv[1] $cmd[2..-1]
end

# Basic git subcommands
complete -c dotfiles -n __fish_dotfiles_needs_command -a add -d 'Add file contents to the index'
complete -c dotfiles -n __fish_dotfiles_needs_command -a commit -d 'Record changes to the repository'
complete -c dotfiles -n __fish_dotfiles_needs_command -a diff -d 'Show changes between commits, commit and working tree, etc'
complete -c dotfiles -n __fish_dotfiles_needs_command -a status -d 'Show the working tree status'
complete -c dotfiles -n __fish_dotfiles_needs_command -a push -d 'Update remote refs'
complete -c dotfiles -n __fish_dotfiles_needs_command -a pull -d 'Fetch and integrate with another repository'
complete -c dotfiles -n __fish_dotfiles_needs_command -a log -d 'Show commit logs'
complete -c dotfiles -n __fish_dotfiles_needs_command -a reset -d 'Reset current HEAD to the specified state'
complete -c dotfiles -n __fish_dotfiles_needs_command -a restore -d 'Restore working tree files'
complete -c dotfiles -n __fish_dotfiles_needs_command -a checkout -d 'Switch branches or restore files'
complete -c dotfiles -n __fish_dotfiles_needs_command -a rm -d 'Remove files from the working tree and index'
complete -c dotfiles -n __fish_dotfiles_needs_command -a ls-files -d 'Show information about files in the index'
complete -c dotfiles -n __fish_dotfiles_needs_command -a ls-tree -d 'List the contents of a tree object'

# File completions - only show tracked/modified files
# Note: We don't show untracked files to avoid scanning entire home directory (677k+ files)
# Use manual path completion if you need to add a new untracked file
complete -c dotfiles -n '__fish_dotfiles_using_command add' -a '(command git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME diff --name-only 2>/dev/null)' -f -d 'Modified file'

complete -c dotfiles -n '__fish_dotfiles_using_command diff' -a '(command git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME diff --name-only 2>/dev/null)' -f -d 'Modified file'

complete -c dotfiles -n '__fish_dotfiles_using_command restore' -l staged -d 'Restore the index'
complete -c dotfiles -n '__fish_dotfiles_using_command restore; and __fish_contains_opt -s S staged' -a '(command git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME diff --name-only --cached 2>/dev/null)' -f -d 'Staged file'
complete -c dotfiles -n '__fish_dotfiles_using_command restore; and not __fish_contains_opt -s S staged' -a '(command git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME diff --name-only 2>/dev/null)' -f -d 'Modified file'

complete -c dotfiles -n '__fish_dotfiles_using_command reset' -a '(command git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME diff --name-only --cached 2>/dev/null)' -f -d 'Staged file'

complete -c dotfiles -n '__fish_dotfiles_using_command rm' -a '(command git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME ls-files 2>/dev/null | head -n 100)' -f -d 'Tracked file'

complete -c dotfiles -n '__fish_dotfiles_using_command checkout' -a '(command git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME diff --name-only 2>/dev/null)' -f -d 'Modified file'

# Common options
complete -c dotfiles -n '__fish_dotfiles_using_command commit' -s m -l message -d 'Commit message' -r
complete -c dotfiles -n '__fish_dotfiles_using_command commit' -s a -l all -d 'Stage all modified files'
complete -c dotfiles -n '__fish_dotfiles_using_command commit' -l amend -d 'Amend the previous commit'

complete -c dotfiles -n '__fish_dotfiles_using_command push' -s u -l set-upstream -d 'Set upstream for git pull/status'
complete -c dotfiles -n '__fish_dotfiles_using_command push' -s f -l force -d 'Force push'

complete -c dotfiles -n '__fish_dotfiles_using_command reset' -l soft -d 'Reset HEAD only'
complete -c dotfiles -n '__fish_dotfiles_using_command reset' -l hard -d 'Reset HEAD, index and working tree'
complete -c dotfiles -n '__fish_dotfiles_using_command reset' -l mixed -d 'Reset HEAD and index'
