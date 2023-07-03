function gt --wraps=git --description 'returns path to top level of git repo'
git rev-parse --show-toplevel
end

function gd --wraps=batcat --wraps=cd --description 'jumps to top level of git repo'
cd $(git rev-parse --show-toplevel) 
end

function git-prune-local-branches --wraps=git --description 'Removes all local branches which have a deleted remote branch'
    argparse --name="git_prune_local_branches" f/force -- $argv
    or return

    if set -q _flag_force
        git branch -vv | grep ': gone]' | grep -v "\*" | awk '{ print $1; }' | xargs -r git branch -D
    else
        git branch -vv | grep ': gone]' | grep -v "\*" | awk '{ print $1; }' | xargs -r git branch -d
    end
end
