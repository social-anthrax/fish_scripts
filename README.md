# fish_scripts

A very small collection of fish scripts I find useful.

## Functions

- `l.fish`: runs `exa -lagh --git --icons $argv` giving directory information

- `ll.fish`: runs `exa -lgh --git --icons $argv`. Gives the same format as `l` but doesn't show hidden files.

- `git.fish`
  - `gt` returns the path to the top of the git repo
  - `gd` changes directory to the top of the git repo. Will bug out and move you to ~ if not in a git repo.
  - `git-prune-local-branches`: Runs `git fetch --prune` and then removes all local branches which have a deleted remote branch.
  - `git-hook-aware`: Runs git commands with hooks disabled if `disable_hooks` is set.
  - `git-get-remote`: Returns the remote tracking branch for a local branch name.
  - `git-pull-all-exist-local`: Stashes all untracked and staged files, then iterates over all local branches pulling from remote. It will skip all branches that have commits that have not yet been pushed to remote. Once all branches are pulled it will switch back to the original branch, re-enable hooks and pull again. The stash by default is named and applied so it's not removed if there is conflict and can be applied again.
    - `-s/--drop_stash` disables the persistent stash, and the stash will be popped instead.
    - `-h/--enable_hooks` flag can be used to re-enable git hooks for each operation.
    - `-d/--dry` will print out the commit difference between each local branch and its remote tracking branch without switching or pulling.

## Installation

### Via Fisher (recommended)

Install fisher if you haven't already: <https://github.com/jorgebucaran/fisher>

```sh
fisher install social-anthrax/fish_scripts
```

### From git

Git clone the repo wherever you would like it to live. The install.fish script will symlink the functions into `~/.config/fish/functions` directory.
Alternively move the files in the functions dir to your fish functions dir manually.

```sh
git clone git@github.com:social-anthrax/fish_scripts.git
cd ./fish_scripts
./install.fish
```

## Requirements

- exa with git and icons in path (<https://the.exa.website/#installation>)
- git
