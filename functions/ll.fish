function ll --wraps=ls --wraps=exa --description 'List contents of directory using long format'
    exa -lgh --git --icons $argv
end
