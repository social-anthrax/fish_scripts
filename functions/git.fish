function gt --wraps=git --description 'returns path to top level of git repo'
    git rev-parse --show-toplevel
end

function gd --wraps=cd --description 'jumps to top level of git repo'
    cd $(git rev-parse --show-toplevel)
end

function git-prune-local-branches --description 'Removes all local branches which have a deleted remote branch'
    argparse --name="git_prune_local_branches" f/force -- $argv
    or return

    git fetch --all --prune

    # https://stackoverflow.com/a/46192689/8746334
    if set -q _flag_force
        git branch -vv | grep ': gone]' | grep -v "\*" | awk '{ print $1; }' | xargs -r git branch -D
    else
        git branch -vv | grep ': gone]' | grep -v "\*" | awk '{ print $1; }' | xargs -r git branch -d
    end
end

function git-hook-aware --wraps=git --description "calls git command and disables hooks"
    if set -q disable_hooks
        git -c core.hooksPath=/dev/null $argv
    else
        git $argv
    end
end


function green-text --wraps=echo:
    set_color green
    echo $argv
    set_color normal
end

function red-text --wraps=echo:
    set_color red
    echo $argv
    set_color normal
end

function git-get-remote
    git for-each-ref --format='%(upstream:short)' "$(git config branch.$argv[1].merge)"

end

function git-get-diff --description="Prints the number of commits ahead and behind argv[1] and argv[2] are" -a local -a remote
    git rev-list --left-right --count $local...$remote | read -l ahead behind
    green-text "$local is $ahead commits ahead and $behind commits behind $remote"
end


function git-pull-all-exist-local --description 'Pulls all local branches unless they contain unpushed commits or uncommited files'
    argparse --name="git-pull-all-exist-local" d/dry s/drop_stash h/enable_hooks -- $argv

    # Ignore all git hooks, we don't accidentally want to invoke anything
    if not set -q _flag_enable_hooks
        set -g disable_hooks git 1
    else
        set -e disable_hooks
    end

    set -f stash_name pull_all_stash_backup

    if set -q _flag_dry
        green-text "Dry run, no files will be modified"
    end

    green-text "Running git fetch --all --prune"
    git-hook-aware fetch --all --prune

    set -f current_branch (git rev-parse --abbrev-ref HEAD)
    green-text "Current branch is $current_branch"

    # Checks if current branch contains untracked or commits not in remote
    set -f untracked_or_uncommited (git status --porcelain=v2 2>/dev/null)

    if test -n "$untracked_or_uncommited"
        red-text "$current_branch contains uncommited or untracked files, stashing"
        if not set -q _flag_dry
            # if there was an old stashed variable
            set -f stashed 1
            git stash --all -m "$stash_name"
        end
    end

    # Read all local branches into branches: list[str]
    git for-each-ref --format='%(refname:short)' refs/heads | read -z -a branches

    for branch in $branches
        if test "$branch" = "$current_branch"
            green-text "Skipping original branch for now"
            continue
        end

        set -f remote (git-get-remote $branch)

        if test -z "$remote"
            red-text "No remote found for $branch, skipping."
            continue
        end


        git-get-diff $branch $remote
        # Skip actually changing branches in dry mode
        if set -q _flag_dry
            continue
        end

        # switch to branch
        green-text "Switching to $branch"
        git-hook-aware switch "$branch" --quiet
        # Check if branch contains local commits but using the log
        set -f local_only_commits (git log $branch --not --remotes)
        if test -n "$local_only_commits"
            red-text "$branch contains unpushed commits, skipping"
            continue
        end

        # If remote is set pull from remote (We want to avoid errors as much as possible)
        if not set -q _flag_dry
            green-text Pulling $branch from "$remote"
            git-hook-aware pull
        end
    end


    # Switch back to current branch
    git-hook-aware switch $current_branch --quiet

    # Pop stash
    if set -q stashed
        if set -q _flag_drop_stash
            green-text "Popping stash $stash_name"
            git-hook-aware stash pop
        else
            green-text "Applying stash $stash_name. This stash will not be removed in case of conflicts"
            git-hook-aware stash apply "stash^{/$stash_name}"
        end
    end

    # Re-enable hooks
    set -e disable_hooks

    # Pull with hooks re-enabled in case as that is usually expected behaviour
    set -f remote (git-get-remote $current_branch)
    if test -n "$remote"
        if not set -q _flag_dry
            green-text Pulling $current_branch from "$remote"
            git-hook-aware pull
        end
    else
        red-text "No remote found for $branch"
    end
end
