function l --wraps=exa --description 'List contents of directory using exa'
    exa -lagh --git --icons $argv
end
