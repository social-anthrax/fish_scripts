function l --wraps=exa --description 'List contents of directory using exa'
    exa -lagh --git --icons $argv
end
# Defined in /opt/homebrew/Cellar/fish/3.5.1/share/fish/functions/ll.fish
function ll --wraps=ls --wraps=exa --description 'List contents of directory using long format'
    exa -lgh --git --icons $argv
end
