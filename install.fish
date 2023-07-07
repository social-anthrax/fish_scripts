#! /usr/bin/env fish

for func_path in ./functions/*
    ln -s (realpath $func_path) ~/.config/fish/functions
end
