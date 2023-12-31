complete -c git-pull-all-exist-local -f
complete -c git-pull-all-exist-local -s h -l help -d "Show help"
complete -c git-pull-all-exist-local -s d -l dry -d "Print out the commit differences between each local branch and it's remote tracking branch without switching or pulliing"
complete -c git-pull-all-exist-local -s s -l drop_stash -d "Disables the persistent stash, popping the stash instead of applying it"
complete -c git-pull-all-exist-local -s e -l enable_hooks -d "Enables git hooks for all branches instead of just the current branch"
