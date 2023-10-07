function l --wraps=exa --description 'List contents of directory using exa'
    # If env var exa_no_git is set then ignore 
    if set -q exa_no_git
        eza -lagh --icons $argv
    else
        eza -lagh --git --icons $argv
    end
end

