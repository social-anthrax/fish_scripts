complete git-prune-local-branches -s f -l force -d "Force deletion of removed branches"

complete -c git-pull-all-exist-local -f
complete -c git-pull-all-exist-local -s h -l help -d "Show help"
complete -c git-pull-all-exist-local -s d -l dry -d "Print out the commit differences between each local branch and it's remote tracking branch without switching or pulliing"
complete -c git-pull-all-exist-local -s s -l drop_stash -d "Disables the persistent stash, popping the stash instead of applying it"
complete -c git-pull-all-exist-local -s e -l enable_hooks -d "Enables git hooks for all branches instead of just the current branch"

complete -c git-get-diff -f -a "(__fish_git_branches)" -a "(__fish_git_branches)"

complete -c git-stash-clear-confirm -s f -l force -d "Force drop all stashes"

complete -c git-rebase-merge-base -f -a "(__fish_git_branches)"
